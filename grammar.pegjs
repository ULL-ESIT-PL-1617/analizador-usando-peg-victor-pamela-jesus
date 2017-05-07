start
  = codigo:(primario)*{
    return{
      type: "CODIGO",
      value: codigo
    }
  }

primario 
  = decl:declaracion{
    return {
      type: "PRIMARIO",
      value: decl
    }
  }
  / asig:asignacion{
    return {
      type: "PRIMARIO",
      value: asig
    }
  }
  / llam:llamada{
    return {
      type: "PRIMARIO",
      value: llam
    }
  }
  
declaracion
  = VAR asig:asignacion {
    return {
      type: "DECLARACION",
      value: asig
    }
  }

asignacion
  = id:$ID ASSIGN func:funcion SEMIC {
    return {
      type: "ASIGNACION",
      id: id,
      value: func
    }
  }
  / id:$ID ASSIGN expr:expression SEMIC {
    return {
      type: "ASIGNACION",
      id: id,
      value: expr
    }
  }
  / id:$ID ASSIGN asig:asignacion SEMIC {
    return {
      type: "ASIGNACION",
      id: id,
      value: asig
    }
  }
    
funcion
  = FUNCTION LEFTPAR param:(parametro)* RIGHTPAR LEFTBRACE instr:(instruccion)*
    RIGHTBRACE {
      return{
        type: "FUNCION",
        parameters: param,
        instructions: instr
      }
    }
  
instruccion
  = decl:declaracion s:$SEMIC{
    return {
      type: "INSTRUCCION",
      value: decl,
      semic: s
    }
  }
  / sent:sentencia s:$SEMIC{
    return {
      type: "INSTRUCCION",
      value: sent,
      semic: s
    }
  }
  / buc:bucle s:$SEMIC{
    return {
      type: "INSTRUCCION",
      value: buc,
      semic: s
    }
  }
  / asig:asignacion s:$SEMIC{
    return {
      type: "INSTRUCCION",
      value: asig,
      semic: s
    }
  }
  / llam:llamada s:$SEMIC{
    return {
      type: "INSTRUCCION",
      value: llam,
      semic: s
    }
  }

expression
  = left:term oper:ADDOP right:expression{
    return{
      type: "EXPRESION",
      leftT: left,
      op: oper,
      rightT: right
    }
  }
  / left:term{
    return{
      type: "EXPRESION",
      value: left
    }
  }

term
  = left:factor oper:MULOP right:term{
    return{
      type: "TERM",
      leftT: left,
      op: oper,
      rightT: right
    }
  }
  / left:factor{
    return{
      type: "TERM",
      value: left
    }
  }

factor
  = lp:$LEFTPAR exp:expression rp:$RIGHTPAR {
    return {
      type: "FACTOR",
      value: expression
    }
  }
  / int:$integer {
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
  = IF lp:LEFTPAR cond:condicion rp:RIGHTPAR lb:LEFTBRACE (instruccion)* rb:RIGHTBRACE elseterm:(ELSE LEFTBRACE inst:(instruccion)* RIGHTBRACE)? {
    return {
      type: "SENTENCIA",
      leftp: lp,
      condicion: cond,
      rightp: rp,
      leftb: lb,
      instruccion: inst,
      rightb: rb,
      elseterm: elseterm
    }
  }

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
  = id:$ID lp:$LEFTPAR params:(parametro)* rp:$RIGHTPAR s:$SEMIC{
      return {
        type: "LLAMADA",
        id: id,
        lp: lp,
        params: params,
        rp: rp,
        semic: s
      }
    }
  
  
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

FUNCTION = _"FUNCTION"_
WHILE = _"WHILE"_
IF = _"IF"_
VAR = _"VAR"_
ELSE = _"ELSE"_
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
SEMIC = _";"_
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
