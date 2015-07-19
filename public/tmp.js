(function(){
  var moduleMap = {};
  window.thin = {
    define: function(name, dependents, factory){
      if (!moduleMap[name]) {
        var module = {
          name: name,
          dependents: dependents,
          factory: factory
        };
        moduleMap[name] = module;
      }
      return moduleMap[name];
    },
    use: function(name){
      var module = moduleMap[name];
      if (!module.entity) {
        var args = [];
        for (var i = 0; i < module.dependents.length; i++) {
          if (moduleMap[module.dependents[i]].entity) {
            args.push(moduleMap[module.dependents[i]].entity)
          } else {
            args.push(this.use(module.dependents[i]))
          }
        };
        module.entity = module.factory.apply(this, args);
      };
      return module.entity;
    }
  };
})();
