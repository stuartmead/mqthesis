% mqthesis.cls - Macquarie University PhD and MRes Thesis LaTeX Class File.
%
% Copyright (C) 2004 Paul Cochrane
% Copyright (C) 2008-2015 Alexei Gilchrist
% Copyright (C) 2015 Stuart Mead
% 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%   
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%    
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mqthesis}[2013/10/14 Macquarie University physics thesis LaTeX class]

% MQ2015 Closest match for Georgia with math support:
\usepackage{newtxtext}
% newtxmath is loaded below, after amsmath


% ifthenelse for if loops
\RequirePackage{ifthen}

% is the thesis for Phd, MRes or Hons?  
% define the default first
\newcommand{\degreetext}{for the degree of Doctor of Philosophy}
\DeclareOption{phd}{\renewcommand{\degreetext}%
{for the degree of Doctor of Philosophy}}
\DeclareOption{mres}{\renewcommand{\degreetext}%
{for the degree of Master of Research}}
\DeclareOption{hons}{\renewcommand{\degreetext}%
{in partial fulfilment of the degree of Bachelor of Science with Honours}}

% print a copyright page on the back of the title page?
\newboolean{copyrightpage}
\setboolean{copyrightpage}{false}
\DeclareOption{copyrightpage}{\setboolean{copyrightpage}{true}}

% print ``Examiner's copy'' on the title page?
\newboolean{examinerscopy}
\setboolean{examinerscopy}{false}
\DeclareOption{examinerscopy}{\setboolean{examinerscopy}{true}}


% print grey chapter numbers instead of MQ corporate color "sand"?
\newboolean{greychapternumbers}
\setboolean{greychapternumbers}{false}
\DeclareOption{greychapternumbers}{\setboolean{greychapternumbers}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using a4paper
\LoadClass[12pt, a4paper]{book}

% MQ specification 
% "Margins should be not less than 3.5cm on the binding edge, 
% 1.5cm on the opposite edge and 1.5cm at the top and bottom 
% to allow for binding and trimming.""
\usepackage[top=2.0cm, bottom=2.0cm, inner=3.5cm, outer=2.0cm, includehead]{geometry}


\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.8} %   Default = 0.5

% macros for defining the department, various dates and the title and
% author of the thesis.
\def\department#1{\gdef\@department{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\@title{}
\def\@author{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\def\@copyrightyear{\number\the\year}

%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

% This constructs the MQ title page
\def\titlep{%
    \thispagestyle{empty}%
    \null\vskip.5in%
    \begin{center}
            {\huge\expandafter{\@title}} \\[2.5cm]
            By \\[2.5cm]
            \textbf{\@author}\\
    \end{center}
    \vfill
    \begin{center}
        A thesis submitted to Macquarie University\\
        \degreetext{}\\
        Department of \expandafter{\@department}\\
        \@submitdate\\[3cm]
        \includegraphics[width=0.3 \columnwidth]{MQlogo}\\
    \end{center}
    \ifthenelse{\boolean{examinerscopy}}{%
        \begin{center}
            %\vskip1in
            {\LARGE {Examiner's Copy}}
        \end{center}%
        }{}
    \vfill
    \newpage}

% this defines the signature for the signature page where the standard
% declaration is put
\long\def\signature#1{%
\begin{center}
\begin{minipage}{4in}
\parindent=0pt
Except where acknowledged in the customary manner, the material
presented in this thesis is, to the best of my knowledge, original and
has not been submitted in whole or part for a degree in any university.
\par
\vspace{.5in}
\hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\#1}}
\end{minipage}
\end{center}}

% this is the actual signature page
\def\signaturepage{%
	\vskip.5in
	\signature{\@author}}

% improved version of caption handling
\usepackage{ccaption}
\captionnamefont{\scshape}
\captionstyle{}
\makeatletter
\renewcommand{\fnum@figure}[1]{\quad\small\textsc{\figurename~\thefigure}:}
\renewcommand{\fnum@table}[1]{\quad\small\textsc{\tablename~\thetable}:}
\renewcommand{\@makecaption}[2]{%
\vskip\abovecaptionskip
\sbox\@tempboxa{#1: #2}%
\ifdim \wd\@tempboxa >\hsize
  \def\baselinestretch{1}\@normalsize
  #1: #2\par
  \def\baselinestretch{1.5}\@normalsize
\else
  \global \@minipagefalse
  \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
\fi
\vskip\belowcaptionskip}
\makeatother

% now put in the titlepage
% (bit of a misnomer really, as it is really the first three or four pages.
\def\titlepage{%
    \pagenumbering{roman}  % make sure that front matter is numbered Roman
    \titlep
    \ifthenelse{\boolean{copyrightpage}}{%
        \newpage
        \vspace*{\fill}
        \begin{center}
            \copyright{} \@author, \@copyrightyear.
        \end{center}
        \begin{center}
            Typeset in \LaTeXe{}.
        \end{center}
        \normalsize
        \newpage
        \signaturepage}{}
}


\usepackage{color}

\usepackage[grey,times]{quotchap}

% set the pagestyle to look good
\pagestyle{fancy}

%%%%% Fancyhdr stuff
% give the header a bit more room, otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}
% define how headers are marked, for details, see fancyhdr docs
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details
% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
\fancyhead[LE,RO]{\sc \nouppercase{\thepage}}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RE]{\nouppercase{\leftmark}}

% \chapter issues a \thispagestyle{plain} .. override plain
% Redefine the plain page style
\fancypagestyle{plain}{%
  \fancyhf{}%
   \renewcommand{\headrulewidth}{0pt}% Line at the header invisible
}

%%% other settings required for a thesis
% It's a references section, not a bibliography, hence redefine
% \bibname i.e. change ``Bibliography'' to ``References''
\renewcommand*{\bibname}{References}

% use 1.5 line spacing for the examiners copy
% single line spacing for the final copy
\ifthenelse{\boolean{examinerscopy}}{%
\renewcommand{\baselinestretch}{1.5}}%
{\renewcommand{\baselinestretch}{1}}

% spell things correctly
\newenvironment{centre}{\begin{center}}{\end{center}}
\newenvironment{itemise}{\begin{itemize}}{\end{itemize}}

\usepackage{makeidx}

% MQ2015  Sand=R214 G210 B196  
\ifthenelse{\boolean{greychapternumbers}}{}{%
\definecolor{chaptergrey}{rgb}{0.839,0.824,0.769}%
}

%%%%% set up the bibliography style
\bibliographystyle{mqthesis}  % mqthesis bibliography style file, made
			                  % with makebst

%%%%% optional packages
\usepackage[square,comma,numbers,sort&compress]{natbib}
		% this is the natural sciences bibliography citation
		% style package.  The options here give citations in
		% the text as numbers in square brackets, separated by
		% commas, citations sorted and consecutive citations
		% compressed 
		% output example: [1,4,12-15]

\usepackage[]{tocbibind}  
				% allows the table of contents, bibliography
				% and index to be added to the table of
				% contents if desired, the option used
				% here specifies that the table of
				% contents is not to be added.
				% tocbibind needs to be after natbib
				% otherwise bits of it get trampled.

\usepackage{graphicx} % standard graphics package for inclusion of
              % images and eps files into LaTeX document

\usepackage{amsmath,amsfonts,amssymb} % this is handy for mathematicians and physicists
			      % see http://www.ams.org/tex/amslatex.html

% load this after amsmath
\usepackage{newtxmath}

\usepackage[pdfusetitle]{hyperref}
\hypersetup{
    colorlinks=false,  % false: boxed links; true: colored links
    linkcolor=black,   % color of internal links 
    citecolor=black,   % color of links to bibliography
    filecolor=black,   % color of file links
    urlcolor=black,    % color of external links
    }
\urlstyle{same}


