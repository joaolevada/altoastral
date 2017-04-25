var app = new Vue({
    el: '#app',
    data: {
        message: 'Hello VueJS!'
    }
});

var app2 = new Vue({
    el: '#app-2',
    data: {
        message: 'You loaded this page on ' + new Date()
    }
});

var app3 = new Vue({
    el: '#app-3',
    data: {
        seen: true
    }
});

var app4 = new Vue({
    el: '#app-4',
    data: {
        todos: [
            { text: 'Learn JavaScript' },
            { text: 'Learn Vue' },
            { text: 'Forget Java' },
            { text: 'Build something awesome' }
        ]
    }
});

var app5 = new Vue({
    el: '#app-5',
    data: {
        message: 'Socorram me subi num onibus em Marrocos'
    },
    methods: {
        reverseMessage: function() {
            this.message = this.message.split('').reverse().join('');
        }
    }
});

var app6 = new Vue({
    el: '#app-6',
    data: {
        message: 'Hello Vue!'
    }
});

Vue.component('todo-item', {
    props: ['todo'],
    template: '<li>{{ todo.text }}</li>'
});

var app7 = new Vue({
    el: '#app-7',
    data: {
        groceryList: [
            { text: 'Vegetables' },
            { text: 'Cheese' },
            { text: 'Whatever else humans are suposed to eat (or drink)' }
        ]
    }
});



var example = new Vue({
    el: '#example',
    data: {
        message: 'Socorram me subi no onibus em Marrocos'
    },
    computed: {
        reversedMessage: function() {
            rm = this.message.split('').reverse().join('');
            return rm;
        }
    }
});

var watchExample = new Vue({
    el: '#watch-example',
    data: {
        question: '',
        answer: 'I cannot give you an answer until you ask a question!'
    },
    watch: {
        question: function(newQuestion) {
            this.answer = 'Waiting for you to stop typing...',
                this.getAnswer()
        }
    },
    methods: {
        getAnswer: _.debounce(
            function() {
                if (this.question.indexOf('?') === -1) {
                    this.answer = 'Question usually contain a question mark. ;-)';
                    return;
                }
                this.answer = 'Thinking...';
                var vm = this;
                axios.get('https://yesno.wtf/api')
                    .then(function(response) {
                        vm.answer = _.capitalize(response.data.answer)
                    })
                    .catch(function(error) {
                        vm.answer = 'Error! Could not reach the API. ' + error;
                    });
            },
            500 //wait until user stop typing
        )
    }
});