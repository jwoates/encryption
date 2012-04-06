var FormSet = new Class({
  Implements: [Options,Events],
  options:{
      selection: null,
      classname: null,
      index: null
  },
  initialize: function(id, options, events){
    this.setOptions(options);
    this._radios     = null;
    this._item       = id;
    this._classname  = this.options.classname;
    this._index      = this.options.index;
    this._valid      = false;
    this.init();
  },
  init: function(){
    this._radios = this._item.getElements('input[type="radio"]')
    this._radios.each(this.behavior.bind(this));
    this._next = this._item.getElement('.next') ? this._item.getElement('.next') : null;
    this._back = this._item.getElement('.back') ? this._item.getElement('.back') : null;
    if(this._next != null) this.set_next(false);
    if(this._back != null) this.set_back(false);
    
  },
  set_next: function(flag){
    if(flag == false){
      this.disable();
    }else{
      this.enable();
      this._next.addEvent('click',this.cycle.bind(this,['forward']))
    }
  },
  set_back: function(flag){
      this._back.disabled = false;
      this._back.fade('in');
      this._back.addEvent('click',this.cycle.bind(this,'back'))
  },  
  cycle: function(direction, event){
    event.stop();
    PI.slideTo(this._index, direction);
  },
  behavior: function(el){
    this.input = new Element('span',{'class':'radio'});
    this.input.inject(el, 'before');
    //el.addEvent('click', this.torpedo.bind(this, el));
    this.input.addEvent('click', this.torpedo.bind(this, el));
  },
  torpedo: function(el,event){
    this._radios.each(function(rdo){
      rdo.checked = 0;
      rdo.getPrevious().removeClass('selected');
      rdo.getNext('label').removeClass('labelSelected')
    })
    el.checked = 1;
    el.getPrevious().addClass('selected');
    el.getNext('label').addClass('labelSelected')
    this.check(el,this);
  },
  enable: function(){
    if(this._next != null){
      this._next.disabled = false;
      this._next.fade('in');
    }
  },
  disable: function(){
    if(this._next != null){
      this._next.disabled = true;
      this._next.setStyle('opacity',.5);
    }
  },
  restart: function(){
    this._radios.each(function(el){
      el.checked = false;
      this._item.addClass(this._classname);
    }.bind(this))
    this.disable();
    PI.fc.check();
    
  },
  check: function(el, self){
    this._radios.each(function(el){
      if(el.checked == true){
        self._item.removeClass(self._classname)
        self._valid = true;
        self.fireEvent('selection');
        if(self._next != null) self.set_next(true);
        PI.fc.check();
      };
    })
  }
});
var FormController = new Class({
  Implements: [Options,Events],
  options:{
      sets: null,
      button: null,
  },
  initialize: function(id, options, events){
    this.setOptions(options);
    this._form              = id;
    this._sets              = this.options.sets;
    // not used // 
    // this._child_function    = this.options.child_function;
    this._setsObj = [];
    this._sets.each(function(el,index){
      this._setsObj.include(new FormSet(el,{classname:'invalid',index:index})); 
    }.bind(this));

  },
  check: function(el, self){
    var flag = true
    this._sets.each(function(el){
      if(el.hasClass('invalid')){
        flag = false
      }
    })
    if(flag === true){
      this.enable();
    }else{
      this.disable();
    }
  },
  submit: function(){
    PI.question_form.send()
  },
  enable: function(){
    this.options.button.fade('in');
    this.options.button.disabled = false;
    this.options.button.addEvent('click',this.submit.bind(this))
  },
  disable: function(){
    this.options.button.fade('.5');
    this.options.button.disabled = true;
    this.options.button.removeEvent('click',this.submit)
  },
  restart: function(){
    this._setsObj.each(function(obj){
      obj.restart();
    })
    this.disable();
  }  
});