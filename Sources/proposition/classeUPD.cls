% G. Gregoire
% contributeurs :
% C. Gay, J. Browaeys
% Essai de classe de these et d'HDR pour Universite Paris-Diderot.
% fonde sur la classe memoir


% Choses a faire :
% definir un headstyle

\NeedsTeXFormat{LaTeX2e}[2009/09/24]

\ProvidesClass{classeUPD}[2010/07/09 v0.2 proposition de classe de
these et d'HDR pour Universite Paris-Diderot.]

\DeclareOption{moyen}{%
  \PassOptionsToClass{11pt}{memoir}}
\DeclareOption{petit}{%
  \PassOptionsToClass{10pt}{memoir}}
%
\newif\if@defaultpage \@defaultpagetrue
\DeclareOption{defaultpage}{\@defaultpagefalse}
\newif\if@widepage \@widepagefalse
\DeclareOption{widepage}{\@widepagetrue}
\newif\if@bringshurstpage \@bringshurstpagefalse
\DeclareOption{bringshurstpage}{\@bringshurstpagetrue}
\DeclareOption*{}%% Ne rien faire quand une option est inconnue

\ProcessOptions*\relax
\LoadClass[a4paper,onecolumn,twoside,openright,final]{memoir}%
[2009/09/21 v1.61803398b]

\RequirePackage[frenchb]{babel}[2008/07/06 v3.8l]
\RequirePackage{ifthen}[2001/05/26]
\RequirePackage{graphicx}[1999/02/16]
\RequirePackage{epstopdf}[2009/10/17 v2.4]
\RequirePackage{xcolor}[2007/01/21 v2.11]
\RequirePackage{picture}[2009/10/11 v1.3]
\RequirePackage{eso-pic}[2006/07/14 v1.1d]
\RequirePackage{xargs}[2008/03/22 v1.1]
\RequirePackage[T1]{fontenc}[2008/07/06 v3.8l]
\RequirePackage{microtype}[2009/03/27 v2.3d]
\RequirePackage{lmodern}
\RequirePackage{fourier}[2005/01/30]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition de la page
%
% La largeur de l'alphabet est \the\mylength, ici ma page contient 65
% caracteres de large et 50 lignes de hauteur:
\newlength{\mylength}%
\newcommand{\alphabet}{abcdefghijklmnopqrstuvwxyz}%
\settowidth{\mylength}{\alphabet}%

\if@defaultpage % sinon default de memoir
  \if@widepage % mise en page tres remplie
    \settypeblocksize{*}{0.707\paperwidth}{1.62}
    % textheight textwidth ratio
    \setlrmargins{*}{*}{2} 
    % edge=ratio*spine % left/right margins
    \setulmargins{*}{0.707\foremargin}{*}
    % 
    \setheadfoot{\onelineskip}{3\onelineskip} % headheight footskip
    \setheaderspaces{*}{2\onelineskip}{*} % head/drop sep ratio
  \else % mise en page GG-JB
    \if@bringshurstpage    
      \settypeblocksize{*}{12.25cm}{2.02}
      % textheight textwidth ratio
      \setlrmargins{*}{*}{4} 
      % edge=ratio*spine % left/right margins
      \setulmargins{*}{*}{2}
      % upper/lower margin
      % 
      \setheadfoot{\onelineskip}{3\onelineskip} % headheight footskip
      \setheaderspaces{*}{\onelineskip}{*} % head/drop sep ratio
    \else
      \settypeblocksize{*}{2.5\mylength}{1.866}
      % \settypeblocksize{*}{12.25cm}{2.02}
      % textheight textwidth ratio
      \setlrmargins{*}{*}{2} 
      % \setlrmargins{*}{*}{4} 
      % edge=ratio*spine % left/right margins
      \setulmargins{*}{0.707\foremargin}{*}
      % \setulmargins{*}{*}{2}
      % upper/lower margin
      % 
      \setheadfoot{\onelineskip}{3\onelineskip} % headheight footskip
      \setheaderspaces{*}{2\onelineskip}{*} % head/drop sep ratio
    \fi
  \fi
\fi 

% un mecanisme automatique de calcul de la marge
% utilisable (il ne semble pas que "memoir" le possede)
% \marginparwidth=\foremargin-3\marginparsep
\setlength{\marginparsep}{1em}%
\setlength{\marginparwidth}{0pt}%
\addtolength{\marginparwidth}{\foremargin}%
\addtolength{\marginparwidth}{-3\marginparsep}%
\setlength{\marginparpush}{\onelineskip} 
% distance verticale entre notes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Pour interdire les orphelins/les veuves
\setlength{\topskip}{1.6\topskip}%
\checkandfixthelayout[classic] % obligatoire si on touche a la mise en
                               % page
\typeoutlayout % pour verifier, impression dans les log
\sloppybottom %veuves et orphelins

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Couverture et titre
%
% Fixer le fond d'une page dans son integralite
% Par une couleur unie
\newcommand{\coverimage}{}
\newcommand{\colorpage}[1][rgb:red,216;green,17;blue,74]{%
  \renewcommand{\coverimage}{%
    \AddToShipoutPicture*{\put(0,0){%
        \begingroup%
        \color{#1}%
        \rule{\paperwidth}{\paperheight}%
        \endgroup%
      }%
    }%
  }%
}%
% ou par une image
\newcommand{\background}[2][height=\paperheight]{%
  \renewcommand{\coverimage}{%
    \AddToShipoutPicture*{\put(0,0){%
        \begingroup%
        \includegraphics[#1]{#2}%
        \rule{\paperwidth}{\paperheight}%
        \endgroup%
      }%
    }%
  }%
}%
\newboolean{these}%
% Position du logo de P7
\newlength{\univyposition}%
\setlength{\univyposition}{-\uppermargin}%
\addtolength{\univyposition}{0.4\paperheight}%
%
\newlength{\univxposition}%
\setlength{\univxposition}{-\spinemargin}%
\addtolength{\univxposition}{-\parindent}%
% Cadre de protection du logo de P7
\newlength{\univheight}%
\setlength{\univheight}{0.1754\paperheight}%
%
\newlength{\sevenpercenty}%
\setlength{\sevenpercenty}{0.0123\paperheight}%
%
\newlength{\univwidth}%
\setlength{\univwidth}{0.08\paperheight}%
\addtolength{\univwidth}{1cm}%
%
\newlength{\sevenpercentx}%
\setlength{\sevenpercentx}{0.0052\paperheight}%
%
% Cadre du titre
% Largeur
\newlength{\titlewidth}%
\newlength{\titlewidthprotect}%
\newlength{\titleposition}%
\setlength{\titleposition}{0.2\paperheight}%
\addtolength{\titleposition}{-1cm}%
\setlength{\titlewidth}{\paperwidth}%
\addtolength{\titlewidth}{-\univwidth}%
\addtolength{\titlewidth}{-0.2\paperheight}%
\setlength{\titlewidthprotect}{\titlewidth}%
\addtolength{\titlewidthprotect}{1cm}%
%
% Logo P7
\newcommand{\logofac}{%
\ClassWarning{classeUPD}{Attention il manque le logo de l'universite}%
}
\newcommand{\logoUpd}[1]{%
  \renewcommand{\logofac}{%
    \includegraphics[height=\univheight,origin=tl]{#1}%
    }%
}
% Logo d'une autre appartenance
\newcommand{\logoone}{}%
\newcommand{\logotwo}{}%
\newcommand{\otherlogo}[3][0]{%
  \ifthenelse{#1 > 0}{%
    \renewcommand{\logoone}{%
      \includegraphics[height=2\onelineskip,origin=tl]{#2}%
    }% end of \logoone
    \ifthenelse{#1 > 1}{%
      \renewcommand{\logotwo}{%
        \includegraphics[height=2\onelineskip,origin=tl]{#3}%
      }% end of \logotwo
    }% end of if 1
    {}% end of then
  }% end of if 2
  {}% end of then
}
% Laboratoire(s)
\newcommand{\labo}[3][0]{%
  \ifthenelse{#1 > 0}{%
    \newcommand{\laboone}{%
      \normalsize\sffamily #2 % 
    }% end of \laboone
    \ifthenelse{#1 > 1}{%
      \newcommand{\labotwo}{%
      \normalsize\sffamily #3 %         
      }% end of \labotwo
    }% end of if
    {\newcommand{\labotwo}{}}% end of then
  }% end of if
  {\newcommand{\laboone}{}}% end of then
}%
%
% Titre
\renewcommand{\title}[1]{%
  \newcommand{\titleitself}{\sffamily\Huge #1}
  \newcommand{\thetitle}{{\normalfont\normalsize #1}}
}
% Auteur
\renewcommand{\author}[1]{%
  \newcommand{\nameofauthor}{\sffamily\LARGE #1}%
  \newcommand{\theauthor}{{\normalfont\normalsize\scshape #1}}%
}
% Specialite
\newcommand{\speciality}[1]{%
  \newcommand{\univspecial}{ -- Licence #1}}
% Universite : par defaut UPD
\newcommand{\univname}{}%
\newcommand{\university}[1][Universit\'e Paris-Diderot]{%
  \renewcommand{\univname}{\normalsize\sffamily #1%
  }}
%
% UFR : par defaut vide
\newcommand{\ufr}[1][]{\newcommand{\faculty}{\normalsize\sffamily #1}}
% Ecole doctorale : par defaut vide
\newcommand{\ed}[1][]{\newcommand{\school}{\normalsize\sffamily #1}}
\newcommand{\defense}[1][jour-dit]{%
  \newcommand{\dateofdefense}{%
    \normalsize\sffamily a pr\'esent\'e publiquement le #1}}%
\newcommand{\works}{\sffamily ses travaux pour l'obtention %
  \ifthenelse{\boolean{these}}%
  {du\\[\onelineskip]{\Large titre de Docteur\univspecial}}%
  {de\\[\onelineskip]{\Large l'Habilitation \`a diriger des recherches}}%
  }%
%
% Variables complementaires
% Hauteur
\newlength{\baselineskipHuge}%
\newcommand{\setbsH}{%
  \Huge \setlength{\baselineskipHuge}{\baselineskip}}%
\setbsH%
\newlength{\baselineskipLARGE}%
\newcommand{\setbsLL}{%
  \LARGE \setlength{\baselineskipLARGE}{\baselineskip}}%
\setbsLL%
\newlength{\baselineskipLarge}%
\newcommand{\setbsL}{%
  \Large \setlength{\baselineskipLarge}{\baselineskip}}%
\setbsL%
\newlength{\baselineskipnormal}%
\newcommand{\setbsn}{%
  \normalsize \setlength{\baselineskipnormal}{\baselineskip}}%
\setbsn%
%
% Couverture
\newboolean{cover}%
\setboolean{cover}{false} % false=no cover up to now
\newcommand{\makecover}%
{%
  \ifthenelse{\not\boolean{cover}}{%
  \setcounter{page}{-1}%
  \setboolean{cover}{true}}{}
  \newlength{\dummy}%
  \newlength{\titleboxheight}%
  \newcommand{\kindoftitle}%
  {\sffamily\normalsize \ifthenelse{\boolean{these}}%
    {Projet de Math\' ematiques\univspecial}%
    {M\'emoire d'habilitation \`a diriger des recherches}%
  }%
  \settoheight{\titleboxheight}{\kindoftitle}%
  \addtolength{\titleboxheight}{\baselineskipHuge}%
  % valeur de \baselineskip \Huge
  \addtolength{\titleboxheight}{\onelineskip}%
%
  \settowidth{\dummy}{\titleitself}%
% Combien de lignes de titre ? (max 3)
  \addtolength{\dummy}{-\titlewidth}%
  \ifthenelse{\dummy > 0}{%
    \addtolength{\titleboxheight}{\baselineskipHuge}%
    \addtolength{\dummy}{-\titlewidth}%
    \ifthenelse{\dummy>0}{%
      \addtolength{\titleboxheight}{\baselineskipHuge}%
      \addtolength{\dummy}{-\titlewidth}%
    }{}%
  }{}%
  % 
  \addtolength{\titleboxheight}{\baselineskipLARGE}%
  \addtolength{\titleboxheight}{\onelineskip}%
  % 
  \settodepth{\dummy}{\nameofauthor}%
  \addtolength{\titleboxheight}{\dummy}%
  \addtolength{\titleboxheight}{-0.2\paperheight}%
  \setlength{\titleboxheight}{-0.5\titleboxheight}%
%
  \thispagestyle{empty}%
  \coverimage%
  \vspace*{\univyposition}%
  \hspace*{\univxposition}%
  \setlength{\fboxsep}{0pt}%
  \colorbox{white}{%
    \parbox{\univwidth}{%
      \vspace*{\sevenpercenty}%
      \hspace*{1cm}%
      \logofac%
      \hspace*{\sevenpercentx}%
      \vspace*{\sevenpercenty}%
    }%
  }%
  \hspace*{\titleposition}%
  \colorbox{white}{%
    \begin{minipage}{\titlewidthprotect}%
      \parbox{\titlewidth}{%
        \centering%
        \vspace*{\titleboxheight}%
        \kindoftitle\\[\onelineskip]%
        \titleitself\\[\onelineskip]%
        \nameofauthor%
        \vspace*{\titleboxheight}}%
    \end{minipage}%
  }%
  \cleardoublepage\normalfont
}%
%
%Page de titre
\newlength{\bottommargin}%
\setlength{\bottommargin}{\paperheight}%
\addtolength{\bottommargin}{-\uppermargin}%
\addtolength{\bottommargin}{-\textheight}%
\addtolength{\bottommargin}{-2\onelineskip}%
%
\newlength{\lengthofrule}%
\setlength{\lengthofrule}{\paperwidth}%
\addtolength{\lengthofrule}{-2cm}%
%
\newlength{\lengthofbox}%
\setlength{\lengthofbox}{\lengthofrule}%
\addtolength{\lengthofbox}{-2\parindent}%
%
\newlength{\labobox}%
\setlength{\labobox}{\lengthofbox}%
\addtolength{\labobox}{-4\onelineskip}%
%
\newlength{\rulexposition}%
\newlength{\indentleftrulexposition}%
\setlength{\rulexposition}{0.94cm}%
\addtolength{\rulexposition}{-\spinemargin}%
\setlength{\indentleftrulexposition}{\rulexposition}%
\addtolength{\indentleftrulexposition}{\parindent}%
%
\newlength{\vertical}%
\setlength{\vertical}{-\uppermargin}%
\addtolength{\vertical}{-\headsep}%
\addtolength{\vertical}{1.5\onelineskip}%
%
\newlength{\namebox}%
\setlength{\namebox}{3\onelineskip}%
\addtolength{\namebox}{6\baselineskipnormal}%
\addtolength{\namebox}{\baselineskipLARGE}%
\addtolength{\namebox}{\baselineskipLarge}%
\setlength{\namebox}{-0.5\namebox}%
\addtolength{\namebox}{0.2\paperheight}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jury
\newcommand{\jury}{%
{\sffamily\Large Jury~:}}%
%
\newcommand{\organizejury}[2]{%
  {\sffamily\Large#1}&{\sffamily\Large#2}\\
}%
%
\newcommand{\presidentname}{}%
\newcommand{\president}[2][Pr\'esident]{%
  \renewcommand{\presidentname}{%
    \organizejury{#1}{#2}%
  }%
}%
%
\newcommand{\dirname}{}%
\newcommand{\direct}[2][Directeur]{%
  \renewcommand{\dirname}{%
    \organizejury{#1}{#2}%
    }%
}%
%
\newcommand{\refereesname}{}%
\newcommand{\referees}[4][Rapporteurs]{%
  \renewcommand{\refereesname}{%
    \organizejury{#1}{#2}%
    \organizejury{}{#3}%
    \ifthenelse{\not\boolean{these}}{%
      \organizejury{}{#4}}%
    {}%
  }%
}%
\newcounter{nbmembers}%
\newcommandx{\othermember}[9][1=0,2,3,4,5,6,7,8,9]{%
  \newcommand{\members}{%
    \setcounter{nbmembers}{#1}%
    \ifthenelse{\thenbmembers > 0}{%
      \organizejury{#2}{#3}%
      \addtocounter{nbmembers}{-1}%
      \ifthenelse{\thenbmembers > 0}{%
        \organizejury{#4}{#5}%
        \addtocounter{nbmembers}{-1}%
        \ifthenelse{\thenbmembers > 0}{%
          \organizejury{#6}{#7}%
          \addtocounter{nbmembers}{-1}%
          \ifthenelse{\thenbmembers > 0}{%
            \organizejury{#8}{#9}}%
          {}}%
        {}}%
      {}}%
    {}%
  }%
}%
%
\newlength{\Tunivxposition}%
\newcommand{\maketitleincover}{%
  % Page de titre
  % depend de \university
  \ifthenelse{\not\boolean{cover}}{%
    \setcounter{page}{-1}%
    \setboolean{cover}{true}}{}%
  % Position du titre de la fac
  \settowidth{\Tunivxposition}{\univname}%
  \setlength{\Tunivxposition}{-0.5\Tunivxposition}%
  \addtolength{\Tunivxposition}{-\parindent}%
  \addtolength{\Tunivxposition}{\rulexposition}%
  \addtolength{\Tunivxposition}{0.5\lengthofrule}%
  % 
  \thispagestyle{empty}%
  \enlargethispage{\bottommargin}%
  \vspace*{\vertical}%
  \hspace*{\Tunivxposition}%
  \univname\\
  \hspace*{\rulexposition}%
  \rule{\lengthofrule}{0.5pt}\\
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{%
    \faculty\hfill\school}\\[\namebox]
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{\centering%
    \nameofauthor\\[\onelineskip]
    \dateofdefense\\
    \works%
  }\\[\namebox]
  % 
  \hspace*{-\spinemargin}%
  \parbox{\univwidth}{%
    \vspace*{\sevenpercenty}%
    \hspace*{1cm}%
    \logofac %
    \hspace*{\sevenpercentx}%
    \vspace*{\sevenpercenty}%
  }%
  \hspace*{\titleposition}%
  \begin{minipage}{\titlewidthprotect}%
    \parbox{\titlewidth}{%
      \centering%
      \titleitself%
    }%
  \end{minipage}%
  \\[\fill]
  \hspace*{-\spinemargin}\hspace{\univwidth}%
  \jury\\[\onelineskip]%
  \hspace*{-\spinemargin}\hspace{\univwidth}%
  \begin{tabular}{ll}
    \presidentname%
    \ifthenelse{\boolean{these}}{\dirname}{}%
    \refereesname%
    \members%
  \end{tabular}%
  \\[\fill]
  \hspace*{\rulexposition}%
  \rule{\lengthofrule}{0.1pt}\\
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{%
    \parbox{2\onelineskip}{\logoone}%
    \hfill%
    \parbox{\labobox}{\centering\laboone\\\labotwo}%
    \hfill%
    \parbox{2\onelineskip}{\logotwo}}%
  \cleardoublepage\normalfont
}%

\renewcommand{\maketitle}{%
  % Page de titre
  % depend de \university
  \ifthenelse{\not\boolean{cover}}{%
  \setcounter{page}{-1}%
  \setboolean{cover}{true}}{}%
  \settowidth{\Tunivxposition}{\univname}%
  \setlength{\Tunivxposition}{-0.5\Tunivxposition}%
  \addtolength{\Tunivxposition}{-\parindent}%
  \addtolength{\Tunivxposition}{\rulexposition}%
  \addtolength{\Tunivxposition}{0.5\lengthofrule}%
  \thispagestyle{empty}%
  \enlargethispage{\bottommargin}%
  \vspace*{\vertical}%
  \hspace*{\Tunivxposition}%
  \univname\\
  \hspace*{\rulexposition}%
  \rule{\lengthofrule}{0.5pt}\\
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{%
    \faculty\hfill\school}\\[\fill]
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{\centering%
    \nameofauthor\\[\onelineskip]
    \dateofdefense\\
    \works%
  }\\[\stretch{1.5}]
  % 
  \hspace*{\indentleftrulexposition}%
  \begin{minipage}{\lengthofbox}%
    \centering%
    \parbox{\titlewidth}{%
      \centering%
      \titleitself%
      }%
  \end{minipage}%
  \\[\stretch{1.5}]
  \hspace*{\indentleftrulexposition}%
  \begin{minipage}{\lengthofbox}%
    \centering%
%  \jury\\[\onelineskip]%
  \begin{tabular}{ll}
    \presidentname%
    \ifthenelse{\boolean{these}}{\dirname}{}%
    \refereesname%
    \members%
  \end{tabular}%
  \end{minipage}%
  \\[\fill]
  \hspace*{\rulexposition}%
  \rule{\lengthofrule}{0.1pt}\\
  \hspace*{\indentleftrulexposition}%
  \parbox{\lengthofbox}{%
    \parbox{2\onelineskip}{\logoone}%
    \hfill%
    \parbox{\labobox}{\centering\laboone\\\labotwo}%
    \hfill%
    \parbox{2\onelineskip}{\logotwo}}%
  \cleardoublepage\normalfont
}%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structure
% voir aussi dans le corps

% Developpement possible : definir un headstyle
\newcommand{\resumesummary}[2]{
  \thispagestyle{plain}%
  \abstractintoc%
  \renewcommand{\abstractname}{R\'esum\'e}%
  \renewcommand{\abstractnamefont}{\large\sffamily}%
  \setlength{\abstitleskip}{0.25\onelineskip}%
  \vspace*{\fill}%
  \strictpagechecktrue%
  \calccentering{\mylength}
  \begin{adjustwidth*}{\mylength}{-\mylength}%
    \begin{abstract}
      #1
    \end{abstract}%
    \vspace*{\onelineskip}%
    \renewcommand{\abstractname}{Abstract}%
    \renewcommand{\abstractnamefont}{\large\sffamily}%
    \begin{abstract}
      #2
    \end{abstract}%
  \end{adjustwidth*}
  \vfill
  \cleardoublepage
}
%
\renewcommand{\partnamefont}{\sffamily\itshape\LARGE}
\renewcommand{\parttitlefont}{\normalfont\sffamily\HUGE}
\renewcommand{\appendixpagename}{Les annexes}
\renewcommand{\appendixtocname}{Les annexes}
%\setsecnumdepth{subsubsection} % local
\maxsecnumdepth{subsection}
% voir la liste des chapitres predefinis
%\chapterstyle{lyhne}\setlength{\afterchapskip}{3\onelineskip}
%\chapterstyle{bianchi}
\makechapterstyle{diderot}{%
  \chapterstyle{default}
  \renewcommand*{\chapnamefont}{\normalfont\Large\sffamily\itshape}%
  \renewcommand*{\chapnumfont}{\normalfont\Large\sffamily\itshape}
  \renewcommand*{\printchaptername}{%
    \chapnamefont\centering\@chapapp}
  \renewcommand{\thechapter}{\Roman{chapter}}
  \renewcommand*{\printchapternum}{\chapnumfont -- \thechapter}
  \renewcommand*{\chaptitlefont}{\normalfont\Huge\sffamily}
  \renewcommand*{\printchaptertitle}[1]{%
    \hrule\vskip\onelineskip \centering \chaptitlefont ##1\par}
  \renewcommand*{\afterchaptertitle}{\vskip\onelineskip \hrule\vskip
    \afterchapskip}
  \renewcommand*{\printchapternonum}{%
    \vphantom{\chapnumfont \textit{9}}\afterchapternum}}
\chapterstyle{diderot}
\setsecheadstyle{\sffamily\huge}
\setsecnumformat{\csname the#1\endcsname.~--~}
\setsubsecheadstyle{\sffamily\Large\raggedright}
\setsubsubsecheadstyle{\sffamily\large}
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOC
%\renewcommand*{\thepart}{\@Roman\c@part}
%\renewcommand*{\thepart}{\Roman{part}}
\renewcommand{\cftpartname}{Partie~}
\renewcommand{\cftpartfont}{\normalfont}
\renewcommand{\cftpartaftersnum}{.~--~}
\renewcommand{\cftchapterfont}{\normalfont}
\renewcommand{\cftpartpagefont}{\normalfont}
\renewcommand{\cftchapterpagefont}{\normalfont}
\renewcommand{\cftchapteraftersnum}{.~--~}
\renewcommand{\cftsectionaftersnum}{.~--~}
\renewcommand{\cfttableaftersnum}{.~--~}
\renewcommand{\cftfigureaftersnum}{.~--~}

\renewcommand{\partnumberline}[1]{%
    \cftpartname\@cftbsnum #1\@cftasnum\@cftasnumb}
\renewcommand{\chapternumberline}[1]{%
  \@chapapp@head\@cftbsnum #1\@cftasnum\@cftasnumb}
\renewcommand*{\numberline}[1]{%
  \@cftn@me\@cftbsnum #1\@cftasnum \@cftasnumb}
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pagination
\copypagestyle{updpage}{companion}
\makeevenhead{updpage}{\sffamily\thepage}{}{\sffamily\leftmark}
\makeoddhead{updpage}{\sffamily\rightmark}{}{\sffamily\thepage}
\makeevenfoot{plain}{}{}{}
\makeoddfoot{plain}{}{}{}
%\makeoddhead{plain}{}{}{\sffamily\thepage}
\aliaspagestyle{part}{empty}
\pagestyle{updpage}
%\pagestyle{companion}
%\pagestyle{Ruled}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dedicace
\newenvironment{dedication}[2][0.3\paperwidth]{%
\thispagestyle{empty}
\newlength{\dedicationposition}
\setlength{\dedicationposition}{#1}
\addtolength{\dedicationposition}{-\paperwidth}
\setlength{\dedicationposition}{-\dedicationposition}
\addtolength{\dedicationposition}{-\spinemargin}
\addtolength{\dedicationposition}{-0.5\marginparwidth}
\vspace*{0.2\textheight}
\hspace*{\dedicationposition}
\begin{minipage}{#1}
\flushright\normalfont
#2
}%
{%
\end{minipage}
\cleardoublepage
}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Les figures
%
% les figures sur une plus grande ligne
\captiondelim{.~--~}
\captionwidth{0.9\textwidth}
\changecaptionwidth
\captiontitlefont{\small}
\captionnamefont{\small}
\newlength{\bigfigdrop}
\setlength{\bigfigdrop}{\marginparsep}
\addtolength{\bigfigdrop}{0.5\marginparwidth}
\newlength{\bigfigwidth}
\setlength{\bigfigwidth}{\bigfigdrop}
\addtolength{\bigfigwidth}{\textwidth}

\newenvironment{bigfigure}{%
  \begin{figure}%
    \centering%
    \strictpagechecktrue%
    \begin{adjustwidth*}{0pt}{-\bigfigdrop}%
    }%
    {\end{adjustwidth*}%
  \end{figure}%
}
\newcommand{\largegraphic}[2][\bigfigwidth]{
\includegraphics[width=#1, clip]{#2}}

% les figures dans la marge : des illustrations
\newcommand{\illustrname}{Illustr.}
\newcommand{\listillustrname}{Table des illustrations}
\newlistof{listofillustrations}{loi}{\listillustrname}
\newlistentry[chapter]{illustr}{loi}{0}
%\newcommand{\theillustr}{\roman{illustr}}
\addtodef{\insertchapterspace}{}%
{\addtocontents{loi}{\protect\addvspace{10pt}}}
\newcommand{\figinmargin}[2][]{%
  \marginpar{%
    \includegraphics[width=\marginparwidth]{#2}%
    #1
  }%
}
\newlength{\widthofcaption}%
\newlength{\munit}%
\setlength{\munit}{1em}
\newcommand{\smallcaption}[2]{%
  \refstepcounter{illustr}%
  \settowidth{\widthofcaption}{#1}%
  \ifthenelse{\widthofcaption < \munit}{%
    \addcontentsline{loi}{illustr}%
    {\protect\numberline{\theillustr.~--~}#2}}{%
    \addcontentsline{loi}{illustr}%
    {\protect\numberline{\theillustr.~--~}#1}%
  }
  \footnotesize\illustrname~\theillustr.~--~#2
}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note de marge
\newcounter{marginnote}[chapter]
\newcommand{\marginmark}{%
  \refstepcounter{marginnote}%
  \,\up{\themarginnote}%
}
\newcommand{\marginmarkin}{%
  \footnotesize\themarginnote .\,%
}
\newcommand{\marginparnote}[1]{%
  \marginmark%
  \marginpar{\marginmarkin\footnotesize#1}%
}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Liste pour CV
\newcommand{\periode}[1]{\normalfont\bfseries\sffamily #1}
\newlength{\deuxmille}
\settowidth{\deuxmille}{\periode{2000-2010}}
\newlength{\mille}
\settowidth{\mille}{\periode{2000}}
\newcommand{\cvlabel}[1]{%
\periode{#1}}%
\newenvironment{cvlist}[1][\deuxmille]{%
  \list{}{%
    \setlength{\labelwidth}{#1}%
    \setlength{\labelsep}{1em}%
    \setlength{\leftmargin}{0.5\labelwidth}%
    \setlength{\rightmargin}{0pt}%
    \setlength{\itemindent}{\labelsep}%
    \addtolength{\itemindent}{0.5\labelwidth}%
    \setlength{\listparindent}{\itemindent}%
    \setlength{\itemsep}{0pt}%
    \let\makelabel\cvlabel}%
}{%
\endlist%
}