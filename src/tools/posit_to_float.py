'''
    Posit to float class

    Author: Samuel Souza da Silva
'''
import re
from operator import itemgetter
from fixed_to_float import *
import math
class posit_to_float:
    def __init__(self, n=32, es=2):
        self.n = n
        self.es = es

    def is_posit(self, bits):
        pattern = re.compile('^[01]+$')

        if (len(bits) == self.n) and (re.search(pattern, bits)):
            return True

        return False

    def ones_comp(self, bits):
        return bits.replace("1", "aux").replace("0", "1").replace("aux", "0")

    def sxor(self, s1, s2):
        ans = ''

        for x, y in zip(s1, s2):
            ans = ans + ('1' if x != y else '0')
        return ans
    
    def _add(self, s1, s2):
        added_number = int(s1, 2) +  int(s2, 2)
        return format(added_number, 'b').rjust(self.n - 1, '0')
    
    def LZOC_and_shift(self, number, target):
        count = 0

        for i in range(0, len(number)):
            if number[i] != target:
                break
            count = count + 1

        return {
            'count': count,
            'shift': number[count:]
            }

    def _extraction(self, bits):
        n = self.n
        es = self.es

        sign = bits[0]
        nzero = True if '1' in bits[1:] else False # Reduction OR
        z = not ((sign == '1') or nzero)
        inf = (sign == '1') and (not(nzero))
        twos = self._add(self.sxor(bits[1:], sign * (n-1)), sign)
        rc = twos[0] # Regime sign
        count, shifted = itemgetter('count', 'shift')(self.LZOC_and_shift(twos, rc))
        msb = len(shifted)
        int_part_frac = '1' if nzero else '0'
        frac_part = int_part_frac + shifted[(es+1):]
        frac = fixed_to_float('0' + frac_part, len(frac_part) - 1, 1)

        if len(shifted) > 1:
            exp_part = shifted[1:(es+1)]
            exp = int(shifted[1:(es+1)], 2) if len(exp_part) > 0 else 0
        else:
            exp = 0

        if rc == '0':
            reg = -1 * count
        else:
            reg = count - 1

        return {
            'sign': sign,
            'reg': reg,
            'exp': exp,
            'frac': frac,
            'z': z,
            'inf': inf
        }
    
    def to_float(self, bits, verbose=False):
        if verbose:
            print('Converting posit number: ', bits)

        extracted_posit = self._extraction(bits)

        if verbose:
            print('Extracted posit parts: ', extracted_posit)

        sign = 1 if extracted_posit['sign'] == '0' else -1
        reg = extracted_posit['reg']
        exp = extracted_posit['exp']
        frac = extracted_posit['frac']
        u = 2**(2**self.es)
    
        converted_number = sign * (u**reg) * (2**exp) * frac

        if verbose:
            print('Float number: ', converted_number)

        return converted_number

###################################################################
#
# For iteractive mode, run: python3 -i src/tools/posit_to_float.py
#
# Example:
#
# posit_string = '10110101010010111101101111111000'
# my_posit_to_float = posit_to_float(n=32, es=2)
# my_posit_to_float.to_float(posit_string, verbose=True)
