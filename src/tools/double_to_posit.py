'''
    WORK IN PROGRESS - STILL UNDER DEVELOPMENT
'''
from posit_to_float import *
import math

class FloatToPosit:
    def __init__(self, n=32, es=2):
        # N: Posit Word Size
        # E: FP Exponent Field Size
        # BIAS = (2**(E-1))-1 : FP Exponent Bias
        #         
        self.n = n
        self.es = es
        self.my_posit_to_float = posit_to_float(n=self.n, es=self.es)

    def compare_to_index(self, target_number, index):
        posit_string = format(index, 'b').rjust(self.n, '0')
        index_number = self.my_posit_to_float.to_float(posit_string)
 
        if index_number > target_number:
            return 'gt'
        if index_number < target_number:
            return 'lt'
        else:
            return 'eq'


    def to_posit(self, in_number, verbose = False):
        is_negative = True if in_number < 0 else False
        
        if is_negative:
            upper_index = 2**(self.n) - 1
            lower_index = 2**(self.n - 1)
        else:
            upper_index = 2**(self.n - 1)
            lower_index = 0
        target_index = int((upper_index + lower_index)/2)
        stop_calculation = False

        if verbose:
            print("------- Start Conversion ----------")
            print('upper_index', format(upper_index, 'b').rjust(self.n, '0'))
            print('lower_index', format(lower_index, 'b').rjust(self.n, '0'))
            print('target_index', format(target_index, 'b').rjust(self.n, '0'))
            print("-----------------------------------")

        while not stop_calculation:
            comparasion_with_current_index = self.compare_to_index(in_number, target_index)
            if comparasion_with_current_index == 'eq':
                stop_calculation = True
            else:
                if verbose:
                    print('before comparasion: ', upper_index, lower_index, target_index)
                
                if comparasion_with_current_index == 'gt':
                    comparasion_result ='gt'
                    upper_index = target_index
                elif comparasion_with_current_index == 'lt':
                    comparasion_result = 'lt'
                    lower_index = target_index
                target_index = int((upper_index + lower_index)/2)
                
                if verbose:
                    print('after comparasion: ', comparasion_result, upper_index, lower_index, target_index)
            
            if (upper_index - lower_index) == 1:
                upper_limit_number =  self.my_posit_to_float.to_float(format(upper_index, 'b').rjust(self.n, '0'))
                lower_limit_number =  self.my_posit_to_float.to_float(format(lower_index, 'b').rjust(self.n, '0'))
                target_index_number = self.my_posit_to_float.to_float(format(target_index, 'b').rjust(self.n, '0'))

                upper_error = abs(upper_limit_number - in_number)
                lower_error = abs(lower_limit_number - in_number)
                target_error = abs(target_index_number - in_number)

                if (target_error > upper_error) and (lower_error > upper_error):
                    target_index = upper_index
                elif (target_error > lower_error) and (upper_error > lower_error):
                    target_index = lower_error
                stop_calculation = True

        return format(target_index, 'b').rjust(32, '0')


########## USAGE EXAMPLE ##########

my_float_to_posit = FloatToPosit(n=32, es=2)
values_to_convert = [0.96816901138, 0.1, 1/math.pi]
for constant in values_to_convert:
    print(my_float_to_posit.to_posit(constant), constant)
