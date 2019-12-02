<template>
  <div>
    <!-- 新規作成部分 -->
    <div class="row">
      <div class="col s10 m11">
        <!-- <input class="form-control" placeholder="Add your task!!"> -->
        <input v-model="newTask" class="form-control" placeholder="Add your task!!">
        <v-date-picker :mode="mode"
               :formats="formats"
               v-model='newDate'
               v-bind:value='newDeadline'
               v-on:input='newDeadline=customformat2()'
               placeholder="Add your task!!"></v-date-picker>
      </div>
      <div class="col s2 m1">
        <!-- <div class="btn-floating waves-effect waves-light red"> -->
        <div v-on:click="createTask" class="btn-floating waves-effect waves-light red">
          <i class="material-icons">add</i>
        </div>
      </div>
    </div>
    <!-- リスト表示部分 -->
    <div>
      <ul class="collection">
　       <li v-for="task in tasks" v-bind:key="task.id"  v-bind:id="'row_task_' + task.id" class="collection-item" v-on:click="selectedTask(task.deadline)">
          <!-- <input type="checkbox" v-on:click="selectedTask(task.deadline)" v-bind:id="'task_' + task.id" /> -->
          <label v-bind:for="'task_' + task.id">{{ task.task }} {{task.deadline}}</label>
          <button class="btn" v-on:click="deleteTask(task.id)">削除</button>
        </li>
      </ul>
    </div>
    <!-- 完了済みタスク表示ボタン -->
    <!-- <div class="btn">Display finished tasks</div> -->
    <div class="btn" v-on:click="displayFinishedTasks">Display finished tasks</div>
    <!-- 完了済みタスク一覧 -->
    <!-- <div id="finished-tasks" class="display_none">
      <ul class="collection">
  　     <li v-for="task in filteredFinishedTasks" v-bind:key="task.id" v-bind:id = "'row_task_' + task.id" class="collection-item">
           <input type="checkbox" v-bind:id="'task_' + task.id" checked="checked" />
           <label v-bind:for="'task_' + task.id"  class="line-through">{{ task.name }}</label>
         </li>
      </ul>
    </div> -->

  <!-- <p>{{diffDate()}}</p> -->
  <p>{{d}}</p>


  </div>
</template>

<script>
   import axios from 'axios';
   import moment from 'moment';

   export default {
     data: function () {
       return {
         tasks: [],
         newTask: '',
         newDate:'',
         newDeadline:'',
         mode: 'single',
         formats: {
          input: ['YYYY-MM-DD'],
         },
         dateFrom:'',
         dateTo:'',
         d:0
       }
     },
     mounted: function () {
       this.fetchTasks();
     },
     methods: {
       fetchTasks: function () {
         axios.get('/api/tasks').then((response) => {
           for(var i = 0; i < response.data.tasks.length; i++) {
             this.tasks.push(response.data.tasks[i]);
            //  console.log(this.tasks[i].deadline);
            console.log(typeof String(this.tasks[i].deadline))
           }
         }, (error) => {
           console.log(error);
         });
       },
      displayFinishedTasks: function() {
          document.querySelector('#finished-tasks').classList.toggle('display_none');
      },
      customformat2: function(){
        console.log(this.newDate);
        return moment(this.newDate).format('YYYYMMDD');
      },
      // diffDate:  function(){
      //    this.dateFrom = moment(this.tasks[0].deadline);
      //    this.dateTo = moment(this.tasks[1].deadline);
      //    console.log(this.dateFrom);
      //    return this.dateFrom.diff(this.dateTo, 'days')
      // },
     createTask: function () {
      //  function typeEquals(type, obj) {
      //     var clas = Object.prototype.toString.call(obj).slice(8, -1);
      //     return clas === type;
      //   }
       console.log(this.newTask);
       console.log(this.newDate);
       console.log(this.newDeadline);
      //  console.log(typeEquals('String', this.newDeadline));
       if (!this.newTask || !this.newDeadline) return;
       axios.post('/api/tasks', { task: { deadline: this.newDeadline,task: this.newTask } }).then((response) => {
         this.tasks.unshift(response.data.task);//配列の先頭にくっつける
         this.newTask = '';
         this.newDeadline = '';
         this.newDate='';
       }, (error) => {
         console.log(error);
       });
       
     },
     selectedTask: function(value){
       this.d=moment().diff(moment(String(value)), 'days')
     },
     deleteTask:function(task_id) {
      axios.delete('/api/tasks/'+ task_id).then(response => {
        this.tasks = [];
        this.fetchTasks();
    })
    }
     },
     computed: {
       
    },
    filters:{
    customformat: function(value){
      return moment(value).format('YYYY-MM-DD');
    },

  },
    
       
   }
 </script>

 <style scoped>
   [v-cloak] {
     display: none;
   }
   .display_none {
     display:none;
   }
   /* 打ち消し線を引く */
   .line-through {
     text-decoration: line-through;
   }
 </style>
