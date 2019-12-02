<template>
<div>
  <v-date-picker :mode="mode"
               :formats="formats"
               v-model="selectedDate"></v-date-picker>

  <p>{{selectedDate|customformat}}</p>
  <p>{{diffDate}}</p>
</div>
</template>

<script>

// import VCalendar from 'v-calendar';
// Vue.use(VCalendar);
// Vue.config.productionTip = false
import moment from 'moment';

export default　{
  data: function(){
    return{
    mode: 'single',
    formats: {
        input: ['YYYY/MM/DD'],
    },
    selectedDate: null,
    dateFrom : moment('20191201')
    }
    
  },

  filters:{
    customformat: function(value){
      return moment(value).format('YYYYMMDD');
    }
  },

  computed:{
    diffDate:  function(){
      return this.dateFrom.diff(this.selectedDate, 'days')
    }
  }

  
}


</script>