document.addEventListener('turbolinks:load', () => {
    var agendaVue = new Vue({
        el: '#trans',

        data: {
            mainStageDay: 1,
            sideStageDay: 1,
        },

        methods: {
            changeDay: function(stage, day) {
                this[stage] = day;
            },

            toggle: function(event) {
                $(event.currentTarget).closest('.agenda-tr').toggleClass('toggled');
            }
        }

    });
});
