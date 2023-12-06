# MACRONIZED

A collection of Latin text notated with macrons to mark vowel quality. The text
itself is stored in plain `.txt` files and can be consumed by other applications
to produce higher level documents.

## LaTeX Support

LaTeX is supported by this repository to produce PDFs that can be printed by
home-printers or submitted to publishers to produce books. Scripts to build
PDFs can be found in the `scripts` directory; these depend on having `bash` and
`xelatex` installed on your system.

### Script Example

Currently there exists some issues regarding LaTeX and file paths. For now, all
scripts need to be run in the `scripts` directory. An example of generating a
PDF of Psalm 50 is shown below:

```
cd ./scripts
./make-chapter-pdf.sh ../vulgate/01-vetus-testamentum/21-psalmi/050.txt PSALMUS
```

The scripts will be improved once major editing of the Latin and English text
is complete (hopefully soon...).

## Recommended Resources

- "Lingua Latina", Hans Ørberg
- "A Primer of Ecclesiastical Latin", John Collins
- "A Dictionary of the Psalter", Dom Matthew Britt O.S.B.
- "New Latin Grammar", Joseph Allen & James Greenough
- https://www.wiktionary.org/
