import os
import sys

import interp_Lif
import interp_Lwhile
import type_check_Lwhile

sys.path.append("../python-student-support-code")
sys.path.append("../python-student-support-code/interp_x86")

import compiler
import interp_Lvar
import type_check_Lvar
import type_check_Lif
from utils import run_tests, run_one_test, enable_tracing
from interp_x86.eval_x86 import interp_x86
import interp_Cif

enable_tracing()

compiler = compiler.Compiler()

typecheck_Lvar = type_check_Lvar.TypeCheckLvar().type_check
typecheck_Lif = type_check_Lif.TypeCheckLif().type_check
typecheck_Lwhile = type_check_Lwhile.TypeCheckLwhile().type_check

typecheck_dict = {
    "source": typecheck_Lwhile,
    "remove_complex_operands": typecheck_Lwhile,
}
interpLvar = interp_Lvar.InterpLvar().interp
interpLif = interp_Lif.InterpLif().interp
interpLWhile = interp_Lwhile.InterpLwhile().interp
interpCif = interp_Cif.InterpCif().interp

interp_dict = {
    "shrink": interpLWhile,
    "partial_eval": interpLWhile,
    "remove_complex_operands": interpLWhile,
    "explicate_control": interpCif,
    "select_instructions": interp_x86,
    "remove_jumps": interp_x86,
    "assign_homes": interp_x86,
    "patch_instructions": interp_x86,
}

if True:
    run_tests("var", compiler, "var", typecheck_dict, interp_dict)
else:
    run_one_test(
        os.getcwd() + "/tests/var/zero.py",
        "var",
        compiler,
        "var",
        typecheck_dict,
        interp_dict,
    )
