(function(){
  var Base, Stream, Nothing;
  Base = require('boo').Base;
  Stream = Base.derive({
    init: function(head, tail){
      this.head = head;
      this.tail = tail;
      return this;
    },
    toString: function(){
      return "<Stream " + this.head + ":" + this.tail() + ">";
    },
    concat: function(as){
      var this$ = this;
      switch (false) {
      case as !== Nothing:
        return this;
      case this !== Nothing:
        return as;
      case this.tail() !== Nothing:
        return this.derive({
          tail: function(){
            return as;
          }
        });
      default:
        return this.derive({
          tail: function(){
            return this$.tail().concat(as);
          }
        });
      }
    },
    empty: function(){
      return Nothing;
    },
    map: function(f){
      var rest, this$ = this;
      rest = this.tail();
      return this.derive({
        head: f(this.head),
        tail: rest === Nothing
          ? function(){
            return Nothing;
          }
          : function(){
            return rest.map(f);
          }
      });
    },
    chain: function(f){
      return f(this.head);
    },
    'of': function(a){
      return Stream.make(a, function(){
        return Nothing;
      });
    },
    reduceRight: function(f, initial){
      switch (false) {
      case this !== Nothing:
        return initial;
      case this.tail() !== Nothing:
        return f(this.head, initial);
      default:
        return f(this.head, this.tail().reduceRight(f, initial));
      }
    },
    reduce: function(f, accumulated){
      var s, rest;
      if (this === Nothing) {
        accumulated;
      }
      s = this;
      while (s !== Nothing) {
        accumulated = f(accumulated, s.head);
        rest = s.tail();
        if (rest === Nothing) {
          break;
        } else {
          s = rest;
        }
      }
      return accumulated;
    }
  });
  Nothing = Stream.make(void 8, function(){
    return Nothing;
  });
  Nothing.toString = function(){
    return '(Nothing)';
  };
  module.exports = {
    Stream: Stream,
    Nothing: Nothing
  };
}).call(this);
