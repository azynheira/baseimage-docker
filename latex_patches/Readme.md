# How to generate PDF documentation for the RFE code

## 1. Install Dependencies

_Note:_ Ubuntu 24.04 would be preferable since all the versions of the packages are available per default in this version

- Utilities (`make` and `grep`)
In Ubuntu: `sudo apt install make`
In Windows: You can get it by getting `MSYS` for example
<br>
- TeXLive suite (2023 version - _must NOT be a lower version_)
  Needed to produce the PDF from LaTeX files generated by Doxygen.

  In Windows: MikTeX <https://miktex.org/download>
  In Ubuntu: `sudo apt install texlive-full`
<br>
- Doxygen (version 1.9.8 _must NOT be a lower version_)
In Windows: <https://www.doxygen.nl/download.html#google_vignette>
In Ubuntu: `sudo apt install doxygen`
<br>
- Inkscape (_only known to work in Ubuntu!_)
  Needed to convert `svg` files to `png`.

  In Windows: <https://inkscape.org/release/1.3.2/windows/64-bit/>
  In Ubuntu: `sudo install inkscape`

## 2. Increase the LaTeX memory

1. Open a command window (Windows key and type `cmd`) or the PowerShell (Windows key and type "Windows PowerShell").
2. At the shell, enter: `initexmf --edit-config-file=pdflatex`
3. Add the following line into the open editor: `main_memory=12000000` save it and quit the editor.
4. Rebuild the format, by entering: `initexmf --dump=pdflatex`

## 3. Generate RFE driver PDF

1) In directory `rfe/docs/Software_Design/Detail_Design_DoxyVisio`, run
   `doxygen Doxy_driver`
   This will create the `latex_driver` directory with all the LaTeX files and figures.

2) On the `latex_driver` directory
    - On Windows: Copy the `Make.bat` file inside the `latex_patches` to `latex_driver`.
    - On Ubuntu: Copy the `Makefile` file inside the `latex_patches` to `latex_driver` .
    - Copy the `doxygen.sty` file inside the latex_patches to  `latex_driver`

3) Fix the generation date of the document in `refman.tex`

4) Run `make fix_latex_files` to fix the `.svg` inclusion in `LaTex`

5) Run `make` to start generating the PDF and go get a coffee :-)

## 4. Generate RFEFW PDF

1) In directory `rfe/docs/Software_Design/Detail_Design_DoxyVisio`, run
   `doxygen Doxy_rfefw`
   This will create the `latex_rfefw` directory with all the LaTeX files and figures.

2) On the `latex_rfefw` directory
    - On Windows: Copy the `Make.bat` inside the `latex_patches` to `latex_rfefw`.
    - On Ubuntu: Copy the `Makefile` inside the `latex_patches` to `latex_rfefw` .
    - Copy `doxygen.sty` inside the latex_patches to  `latex_driver`

3) Fix the generation date of the document in `refman.tex`

4) Run `make fix_latex_files` to fix the `.svg` inclusion in `LaTex`

5) Run `make` to start generating the PDF and go get a coffee :-)
