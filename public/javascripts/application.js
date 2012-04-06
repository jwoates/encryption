var PI = {};
PI.fire = function () {
  "use strict";
  return 'fire';
}

PI.initSlides = function () {
  var container = $('container');
  PI.slide =  new Fx.Scroll(container,{transition: Fx.Transitions.Expo.easeOut,duration:800});
  PI.slide.slides = $('container').getElements('fieldset');

  PI.slideTo = function(index, direction){
    var n = (direction == 'forward') ? index+1 : index-1;
    PI.slide.toElement(PI.slide.slides[n]);
    var bar = $('bar');
    var percent = n*108;
    var  fx = new Fx.Tween(bar, {
      duration: 200,
      transition: 'quad:out',
      property: 'width'
    });
    fx.start(percent);

  }
}
PI.reset = function (flag) {
  var restart = $('restart');
  if(flag == true){
    restart.disabled = true;
    restart.fade('out');
  }else{
    restart.disabled = false;
    restart.fade('in');
  }
}

PI.init = function(setObject, form){
  if(document.body.getElement('.gender_selection')) PI.init_gender();
  var form = (form) ? form : document.body.getElement('form'),
      load_result = document.id('load_result'),
      submit = document.id('submit_quiz');
  if(form == null) return false;
  PI.initSlides();
  PI.question_form = new Form.Request($(form), load_result, {
     onSend:PI.reset.pass(true),
     onSuccess:PI.reset.pass(false)
  });  
  PI.fc = new FormController(form,{
    sets:PI.slide.slides,
    button:submit
  });
}

window.addEvent('domready', PI.init)

PI.init_gender = function(){
  var triggers = document.body.getElements('.gender_selection a');
  triggers.each(PI.gender_event.bind(this));
}

PI.gender_event = function(el){
  el.addEvent('click', PI.trigger_event.bind(this));
}
PI.trigger_event = function(e){
  e.stop();
  var req = new Request.HTML({
    url:e.target.href,
    update:$('load_result'),
    onComplete:function(){
      PI.init();
    }
  });
  req.send();
}