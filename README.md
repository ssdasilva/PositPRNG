# A Hardware-Efficient Chaotic PRNG Exploring Posit Arithmetic for Secure Image Encryption

## Overview

Chaotic systems are attractive for digital and embedded applications due to their inherent unpredictability and sensitivity to initial conditions, making them suitable for applications such as image encryption. However, their implementation in digital hardware often suffers from dynamical degradation caused by limited numerical precision, leading to short periodic orbits and significantly reducing their effectiveness in security-related applications. Additionally, embedded systems impose strict constraints on hardware resources. To address these limitations, this work proposes a hardware-efficient pseudo-random number generator (PRNG) based on a Sugeno-approximated sine-map implementation. The design targets image-encryption applications and is optimized for field-programmable gate array (FPGA)–based embedded systems. We first approximate the sine map using a lightweight Sugeno fuzzy inference system, replacing costly trigonometric operations and enabling implementation with only one addition unit and one multiplication unit; second, we introduce a perturbation mechanism to mitigate finite-precision degradation.

## How It Works

The PRNG uses a Sine Map function approximated through a simple Sugeno Fuzzy inference system. The main VHDL module, `src/pseudorandom_generator/complete_scheme.vhdl`, contains the main PRNG implemented:
- It takes an initial seed value.
- Applies the Sine Map approximation using Posit arithmetic.
- Uses a shift register and masking logic to enhance randomness.
- Outputs a new pseudorandom value at each iteration.

## Repository Organization

- `src/pseudorandom_generator/`
  - `complete_scheme.vhdl`: Main VHDL implementation of the PRNG.
  - `tb_complete_sine_map_scheme.vhd`: Testbench for simulation.
  - `input_A.txt`: Example input seed values.
  - `tb_script.do`, `wave.do`: ModelSim simulation scripts.

- `src/tools/`
  - `double_to_posit.py`: Python script to convert double-precision floats to Posit representation.
  - `posit_lookup_table.py`: Generates lookup tables mapping Posit values to floats.
  - `posit_to_float.py`: Converts Posit bitstrings to floating-point numbers.

- `README.md`: Project documentation.

## How to Run (Using ModelSim)

1. **Open ModelSim** and set your working directory to `src/pseudorandom_generator/`.

2. **Compile the VHDL files**:
   ```
   vcom complete_scheme.vhdl
   vcom tb_complete_sine_map_scheme.vhd
   ```

3. **Run the simulation** using the provided script:
   ```
   do tb_script.do
   ```

4. **View the waveforms**:
   ```
   do wave.do
   ```

5. **Change the input seed** by editing `input_A.txt` if needed.

## Tools Folder Explanation

The tools folder contains a variety of tools useful for conversion between posit and IEEE 754 number systems.

- **double_to_posit.py**  
  Converts standard double-precision floating-point numbers to their Posit representation. Useful for generating test vectors or initializing hardware modules.

- **posit_lookup_table.py**  
  Generates a lookup table mapping all possible Posit values (for a given word size and exponent size) to their corresponding float values. This helps in debugging and validating the hardware implementation.

- **posit_to_float.py**  
  Converts a Posit bitstring to its floating-point equivalent. This is essential for interpreting hardware outputs and for reference during simulation.

---

For any questions or issues, please contact samuelsouza@ufmg.br.