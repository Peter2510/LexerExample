/* primer seccion: codigo de usuario */


%%

/*segunda seccion: configuracion*/

%class Ejemplo1
%standalone
%unicode 
%line 
%column 
%public
%state comentario

WhiteSpace = [\r|\n|\r\n] | [ \t\f]
consonante = [b|c|d|f|g|h|j|k|l|m|n|ñ|p|q|r|s|t|v|w|x|y|z]
vocal = [a|e|i|o|u]
entero = [0-9]+
inicio_comentario = "/**"
fin_comentario = "**/"

%{
  String total = ""; 
  String comen = "";
%}


%eof{
System.out.println("SE TERMINO EL PROGRAMA");
System.out.println("Se encontro el texto: " + total);
System.out.println("Se encontro el comentario: " + comen);
%eof}


%%

/*tercer seccion: reglas lexicas*/

<YYINITIAL> {WhiteSpace}   {System.out.println("Se encontro un ESPACIO en la linea " + (yyline+1) + " columna " + (yycolumn+1));
                           total +=yytext();
                           
                           }

<YYINITIAL> {consonante}   {System.out.println("Se encontro la CONSONANTE " + yytext() + " en la linea " + (yyline+1) + " columna " + (yycolumn+1));
                           total +=yytext();
                           }

<YYINITIAL> {vocal}   {System.out.println("Se encontro la VOCAL " + yytext() + " en la linea " + (yyline+1) + " columna " + (yycolumn+1));
                           total +=yytext();
                      }

<YYINITIAL> {entero}   {System.out.println("Se encontro el ENTERO " + yytext() + " en la linea " + (yyline+1) + " columna " + (yycolumn+1));
                           total +=yytext();
                       }

<YYINITIAL> {inicio_comentario}           {
                                          System.out.println("Ingreso a comentario con " +yytext() );
                                          yybegin(comentario);
                                          

                                          }

<comentario> [^"-->"]   {

                                    System.out.println("Linea de comentario hallada"  + yytext() );
                                    comen +=yytext();

                                    }

<comentario> {fin_comentario}          {
                                       System.out.println("Salio de comentario con " + yytext() );
                                       yybegin(YYINITIAL);
                                       

                                       }


[^] {System.out.println("Error: " + yytext());}




