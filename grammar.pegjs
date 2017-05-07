start
  = 

primario 
  = 
  
declaracion
  = VAR asig:asignacion {
    return {
      type: "DECLARACION",
      value: asig
    }
  }

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
  = lp:$LEFTPAR exp:expression rp:$RIGHTPAR {
    return {
      type: "FACTOR",
      value: expression
    }
  }
  / = int:$integer {
      return {
        type: "FACTOR",
        value: int
      }
  }

condicion
  = left:parametro c:COMPARISONOPERATOR right:parametro {
    return {
      type: "CONDICION",
      left: left,
      op: c, 
      right: right
    }
  }

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
COMPARISONOPERATOR = MENOR / MENORQUE / MAYOR / MAYORQUE / IGUAL / DISTINTO
MENOR = _"<"_ { return '<'; }
MENORQUE = _"<="_ { return '<='; }
MAYOR = _">"_ { return '>'; }
MAYORQUE = _">="_ { return '>='; }
IGUAL = _"=="_ { return '=='; }
DISTINTO = _"!="_ { return '!='; }
