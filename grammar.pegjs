start
  = 

primario 
  = 
  
declaracion
  = 

asignacion
  =
  
funcion
  =
  
instruccion
  =

expression
  =

term
  =

factor
  =

condicion
  =

sentencia
  =

bucle
  = WHILE lp:$LEFTPAR cond:condicion rp:$RIGHTPAR lb:$LEFTBRACE inst:instruccion rb:$RIGHTBRACE s:$SEMIC {
    return {
      type: "BUCLE",
      leftp: lp,
      condicion: cond,
      rightp: rp,
      leftb: lb,
      instruccion: inst,
      rightb: rb,
      semic: s
    }
  }
  
llamada
  = 
  
parametro
  = exp:expression {
    return {
      type: "PARAMETRO",
      value: exp
    }
  }
  / id:$ID {
      return {
        type: "PARAMETRO",
        value: id
      }
  }

integer "integer"
  = NUMBER

_ = $[ \t\n\r]*

ADDOP = PLUS / MINUS
MULOP = MULT / DIV
COMMA = _","_
PLUS = _"+"_
MINUS = _"-"_
MULT = _"*"_
DIV = _"/"_
LEFTPAR = _"("_
RIGHTPAR = _")"_
LEFTBRACE = _"{"_
RIGHTBRACE = _"}"_
SEMIC = _;_
NUMBER = _ $[0-9]+ _
ID = _ $([a-z_]i$([a-z0-9_]i*)) _
ASSIGN = _ '=' _
