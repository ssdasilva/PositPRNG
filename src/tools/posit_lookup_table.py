# Print lookup table
from posit_to_float import *

class PositLookUpTable:
    def __init__(self, n=16, es=2):
        # N: Posit Word Size
        # E: FP Exponent Field Size
        # BIAS = (2**(E-1))-1 : FP Exponent Bias
        #         
        self.n = n
        self.es = es
        self.my_posit_to_float = posit_to_float(n=self.n, es=self.es)
    
    def print_lookup_table(self):
        '''
            zero and infinity and not treated in this lookup table
        '''
        for index in range(2**self.n):
            posit_string = format(index, 'b').rjust(self.n, '0')
            my_float = self.my_posit_to_float.to_float(posit_string)
            print(posit_string, my_float)

# Posit lookup table generation example
my_lookup_table = PositLookUpTable(n=32, es=2)
my_lookup_table.print_lookup_table()