var Jsonp,
  __hasProp = {}.hasOwnProperty;

Jsonp = (function() {
  var PARENT, hash, _ref;

  function Jsonp() {}

  PARENT = (_ref = document.head) != null ? _ref : document.getElementsByTagName('head')[0];

  Jsonp.append = function(element) {
    return PARENT.appendChild(element);
  };

  Jsonp.element = function(src) {
    var el;
    el = document.createElement('script');
    el.src = src;
    el.innerText = "/* JSONP callback element initialized: " + (new Date().toString()) + " */";
    el.onload = function() {
      return el.remove();
    };
    return el;
  };

  Jsonp.query = function(queryObj) {
    var key, params, val;
    if (queryObj == null) {
      queryObj = {};
    }
    if (typeof queryObj === 'string') {
      return queryObj;
    }
    params = [];
    for (key in queryObj) {
      if (!__hasProp.call(queryObj, key)) continue;
      val = queryObj[key];
      params.push("" + key + "=" + val);
    }
    return params.join('&');
  };

  hash = function() {
    hash = '';
    while (hash.length < 12) {
      hash += Math.floor(10 + Math.random() * 26).toString(36);
    }
    return hash;
  };

  Jsonp.get = function(options) {
    var callbackName, data, query, url, _ref1, _ref2, _ref3,
      _this = this;
    if (options == null) {
      options = {};
    }
    url = (function() {
      if ((_ref1 = options.url) != null) {
        return _ref1;
      } else {
        throw 'You need to provide an url';
      }
    })();
    data = (_ref2 = options.data) != null ? _ref2 : {};
    if (options.cache !== true) {
      data.timestamp = new Date().getTime();
    }
    if (options.success != null) {
      callbackName = (_ref3 = options.jsonp_callback) != null ? _ref3 : 'callback_' + hash();
      data.jsonp = callbackName;
      window[callbackName] = function(data) {
        var _ref4;
        if (typeof data === 'string' && (((_ref4 = window.JSON) != null ? _ref4.parse : void 0) != null)) {
          data = JSON.parse(data);
        }
        return options.success.call(_this, data);
      };
    }
    query = this.query(data);
    this.load("" + url + "?" + query);
  };

  Jsonp.load = function(url) {
    return this.append(this.element(url));
  };

  return Jsonp;

})();
