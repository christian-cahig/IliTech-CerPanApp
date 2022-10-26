%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%	IliTech-CerPanApp (version 0.1.1)
%%%%	A custom LaTeX class for generating the Certificate of Panel Approval
%%%%	for use in Mindanao State University - Iligan Institute of Technology
%%%%
%%%%	IliTech-CerPanApp
%%%%	Copyright (C) 2022 - present, Christian Cahig
%%%%	https://github.com/christian-cahig/IliTech-CerPanApp
%%%%	
%%%%	This file is part of a repository under the CC-BY-4.0 license.
%%%%	See `LICENSE` file in the source directory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% IDENTIFICATION
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template/cerpanapp}[2022/10/25 IliTech-CerPanApp class]

%% PRELIMINARY DECLARATIONS
\LoadClass[a4paper, oneside, 11pt]{scrbook}
\RequirePackage[a4paper,
				top=1.5in,
				bottom=1.1in,
				left=1.5in,
				right=1.0in,
				includehead=false,
				headsep=0.3cm,
				headheight=1.5cm,
				includefoot=false,
				footskip=1cm,
				marginparsep=0.0cm,
				marginparwidth=0cm]{geometry}
\RequirePackage{scrlayer-scrpage, afterpage}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[svgnames, dvipsnames]{xcolor}
\RequirePackage{graphicx, eso-pic, tikz, wrapfig}
\RequirePackage{ifthen, xpatch, xspace, multicol}
\usetikzlibrary{calc}

\newcommand{\University}{Mindanao State University -- Iligan Institute of Technology}
\newcommand{\UniversityAddress}{Andres Bonifacio Avenue, Tibanga, 9200 Iligan City}
\newcommand{\SGS}{School of Graduate Studies}
\newcommand{\GSE}{Graduate School of Engineering}

%% OPTIONS
\DeclareOption{college}{ \ClassWarning{IliTech-CerPanApp}{%
	Invalid college name. Choose one of 'cass', 'ccs', 'ceba', 'ced', 'csm', 'coet', and 'con'.%
} }
\DeclareOption{cass}{%
	\gdef\@College{College of Arts and Social Sciences}%
	\gdef\@GradSchool{\SGS}%
}
\DeclareOption{ccs}{%
	\gdef\@College{College of Computer Studies}%
	\gdef\@GradSchool{\SGS}%
}
\DeclareOption{ceba}{%
	\gdef\@College{College of Economics, Business, and Accountancy}%
	\gdef\@GradSchool{\SGS}%
}
\DeclareOption{ced}{%
	\gdef\@College{College of Education}%
	\gdef\@GradSchool{\SGS}%
}
\DeclareOption{csm}{%
	\gdef\@College{College of Science and Mathematics}
	\gdef\@GradSchool{\SGS}%
}
\DeclareOption{coet}{%
	\gdef\@College{College of Engineering and Technology}%
	\gdef\@GradSchool{\GSE}%
}
\DeclareOption{con}{%
	\gdef\@College{College of Nursing}%
	\gdef\@GradSchool{\SGS}%
}

\DeclareOption{type}{ \ClassWarning{IliTech-CerPanApp}{%
	Invalid work type. Choose one of 'dissertation', 'project', and 'thesis'.%
} }
\DeclareOption{dissertation}{ \gdef\@WorkType{dissertation} }
\DeclareOption{thesis}{ \gdef\@WorkType{thesis} }
\DeclareOption{project}{ \gdef\@WorkType{project} }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ExecuteOptions{coet, thesis}
\ProcessOptions\relax

%% MORE DECLARATIONS
\newcommand{\UniversityLogo}{\includegraphics[scale=0.55]{template/msu-iit-logo.png}}

\newcommand{\WorkTitle}[1]{ \gdef\@WorkTitle{#1} }
\newcommand{\WorkAuthor}[1]{ \gdef\@WorkAuthor{#1} }
\newcommand{\Degree}[1]{ \gdef\@Degree{#1} }

\newcommand{\WorkAdvisor}[1]{ \gdef\@WorkAdvisor{#1} }
\gdef\@WorkCoAdvisor{}
\newcommand{\WorkCoAdvisor}[1]{ \gdef\@WorkCoAdvisor{#1} }

\newcommand{\OralExamPanelistA}[1]{ \gdef\@OralExamPanelistA{#1} }
\newcommand{\OralExamPanelistB}[1]{ \gdef\@OralExamPanelistB{#1} }
\gdef\@OralExamPanelistC{}
\newcommand{\OralExamPanelistC}[1]{ \gdef\@OralExamPanelistC{#1} }
\gdef\@OralExamPanelistD{}
\newcommand{\OralExamPanelistD}[1]{ \gdef\@OralExamPanelistD{#1} }

\newcommand{\DeptChairperson}[1]{ \gdef\@DeptChairperson{#1} }
\newcommand{\DeptGradCoordinator}[1]{ \gdef\@DeptGradCoordinator{#1} }
\newcommand{\CollegeGradCoordinator}[1]{ \gdef\@CollegeGradCoordinator{#1} }
\newcommand{\CollegeDean}[1]{ \gdef\@CollegeDean{#1} }

\newenvironment{PanelApproval}{%
	\thispagestyle{empty}
	\AddToShipoutPictureBG*{
		\begin{tikzpicture}[overlay,remember picture]
			\draw[line width=1.7pt]
			($ (current page.north west) + (1.45in, -1.49in) $)
			rectangle
			($ (current page.south east) + (-0.95in, 1.09in) $);
		\end{tikzpicture}
	}%
}{}

\newcommand{\PutHeader}{%
	\begin{wrapfigure}{l}{0.2\textwidth} \UniversityLogo \end{wrapfigure}

	\noindent
	{\small \itshape Republic of the Philippines} \\
	{\small \University} \\
	{\footnotesize \UniversityAddress} \\

	\noindent
	{\normalsize \bfseries \@College} \\
	{\normalsize \bfseries \@GradSchool} \\[-1em]

	\noindent
	\line(1,0){\textwidth}%
}

\newcommand{\PutCertificateTitle}{%
	\begin{center} {\Large \bfseries \sffamily Certificate of Panel Approval} \end{center}%
}

\newcommand{\PutRecommendation}{%
	The {\@WorkType\xspace} attached hereto,
	entitled {\bfseries \emph{\@WorkTitle}\xspace},
	prepared and submitted by {\bfseries \emph{\@WorkAuthor\xspace}}
	in partial fulfilment of the requirements for the degree {\bfseries \emph{\@Degree}\xspace},
	is hereby recommended for approval.%
}

\newcommand{\PutApproval}{%
	This {\@WorkType\xspace} is approved in partial fulfilment of the requirements
	for the degree {\bfseries \emph{\@Degree}\xspace}.%
}

\newcommand{\PutOralExamPanelists}{%
	\begin{multicols}{2}
		\begin{center}
			{\noindent \bfseries \underline{\@OralExamPanelistA}} \\
			{\small Member}
		\end{center}
		\columnbreak
		\begin{center}
			{\noindent \bfseries \underline{\@OralExamPanelistB}} \\
			{\small Member}
		\end{center}
	\end{multicols}
	\ifthenelse{ \equal{\@OralExamPanelistC}{} \AND \equal{\@OralExamPanelistD}{} }{%
		%
	}{%
		\vskip 2em
		\begin{multicols}{2}
			\begin{center}
				\ifthenelse{ \equal{\@OralExamPanelistC}{} }{%
					{\noindent \bfseries \underline{\@OralExamPanelistD}} \\%
				}{%
					{\noindent \bfseries \underline{\@OralExamPanelistC}} \\%
				}
				{\small Member}
			\end{center}
			\columnbreak
			\begin{center}
				\ifthenelse{ \equal{\@OralExamPanelistD}{} }{%
					\vfill\null%
				}{ \ifthenelse{ \equal{\@OralExamPanelistC}{} }{%
					\vfill\null%
				}{%
					{\noindent \bfseries \underline{\@OralExamPanelistD}} \\%
					{\small Member} %
				} }
			\end{center}
		\end{multicols}
	}%
}

\newcommand{\PutAdvisors}{%
	\begin{multicols}{2}
		\begin{center}
			{\noindent \bfseries \underline{\@WorkAdvisor}} \\
			{\small Advisor}
		\end{center}
		\columnbreak
		\ifthenelse{ \equal{\@WorkCoAdvisor}{} }{\vfill\null}{%
			\begin{center}
				{\noindent \bfseries \underline{\@WorkCoAdvisor}} \\
				{\small Advisor}
			\end{center}%
		}
	\end{multicols}%
}

\newcommand{\PutGradSchoolSignatories}{%
	\begin{multicols}{2}
		\begin{center}
			{\noindent \bfseries \underline{\@DeptChairperson}} \\
			{\small Department Chairperson}
		\end{center}
		\columnbreak
		\begin{center}
			{\noindent \bfseries \underline{\@DeptGradCoordinator}} \\
			{\small Department Graduate Program Coordinator}
		\end{center}
	\end{multicols}
	\vskip 1.3em
	\begin{center}
		{\bfseries \underline{\@CollegeGradCoordinator}} \\
		{\small College Graduate Program Coordinator} \\
		\vskip 2em
		{\noindent \bfseries \underline{\@CollegeDean}} \\
		{\small Dean, \@College}
	\end{center}%
}

\newcommand{\PutStuff}{%
	\begin{PanelApproval}
		\PutHeader
		\PutCertificateTitle
		\vskip 1em

		\noindent
		\PutRecommendation
		\vskip 2em

		\PutOralExamPanelists
		\vskip 2em

		\PutAdvisors
		\vskip 2em

		\vfill
		\noindent
		\PutApproval
		\vskip 2em

		\PutGradSchoolSignatories
	\end{PanelApproval}
}
