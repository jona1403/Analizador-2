var TS = (function(){
    var instancia;

    class Table{
        constructor(){
            this.symbols = [];
        }

        add(symbol){
            this.symbols.push(symbol);
        }

        reset(){
            this.symbols = [];
        }

        getSym(name){
            let res = null;

            this.symbols.forEach(symbol=>{
                if(symbol.name == name){
                    res = symbol;
                }
            });

            return res;
        }

        update(symbol){
            this.symbols.forEach(simbolo=>{
                if(symbol.name == simbolo.name){
                    simbolo.value = symbol.value
                }
            });
        }
    }

    function newInstance(){
        return new Table();
    }

    return{
        getInstance:function(){
            if(instancia == null){
                instancia = newInstance();
            }
            return instancia;
        }
    }
})