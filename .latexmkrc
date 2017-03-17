#!/usr/bin/perl

$latex = 'uplatex --kanji=utf8';
$biber = 'biber -u -U --output_safechars';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3;
$pdf_previewer = 'open';
