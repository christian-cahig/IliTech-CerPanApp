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
\newcommand{\College}{College of Engineering and Technology}
\newcommand{\GradSchool}{School of Graduate Studies}

%% OPTIONS
\DeclareOption{college}{ \ClassWarning{IliTech-CerPanApp}{%
	Invalid college name. Choose one of 'cass', 'ccs', 'ceba', 'ced', 'csm', 'coet', and 'con'.%
} }
\DeclareOption{cass}{ \renewcommand{\College}{College of Arts and Social Sciences} }
\DeclareOption{ccs}{ \renewcommand{\College}{College of Computer Studies} }
\DeclareOption{ceba}{ \renewcommand{\College}{College of Economics, Business, and Accountancy} }
\DeclareOption{ced}{ \renewcommand{\College}{College of Education} }
\DeclareOption{csm}{ \renewcommand{\College}{College of Science and Mathematics} }
\DeclareOption{coet}{%
	\renewcommand{\College}{College of Engineering and Technology}
	\renewcommand{\GradSchool}{Graduate School of Engineering}
}
\DeclareOption{con}{ \renewcommand{\College}{College of Nursing} }

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
	{\small \bfseries \MakeUppercase{\College}} \\
	{\small \bfseries \GradSchool} \\[-1em]

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
	\vskip 2em
	\begin{center}
		{\bfseries \underline{\@CollegeGradCoordinator}} \\
		{\small College Graduate Program Coordinator}
	\end{center}
	\vskip 2em
	\begin{multicols}{2}
		\vfill\null
		\columnbreak
		\noindent Approved: \\
		\begin{center}
			{\noindent \bfseries \underline{\@CollegeDean}} \\
			{\small Dean, \College}
		\end{center}
	\end{multicols}%
}
