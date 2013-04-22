open Ast
open Generator


let _ =

   let source = open_in Sys.argv.(1) in
   let lexbuf = Lexing.from_channel source in
   let program = Parser.program Scanner.token lexbuf in
   let python_source_code = (str_of_program program) in
   let file_name = (String.sub Sys.argv.(1) 0 (String.length Sys.argv.(1) - 3)) in
   let dest = file_name ^".clx" in
   let bin = open_out dest in
   output_string bin python_source_code;
   close_out bin;

let file_name = (String.sub Sys.argv.(1) 0 (String.length Sys.argv.(1) - 3)) in
let make_executable = Sys.command ("chmod a+x " ^ file_name ^ ".clx") in
match make_executable with
0 -> "Success!"
| _ -> "Error";