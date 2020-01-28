RSCRIPT = Rscript
SLIDES = slides.pdf

ALL_PLOTS = figures/weighted-dist-plot.pdf \
	figures/conflict.pdf \
	figures/subpost-disagreement.pdf

TEX_FILES = $(wildcard tex-input/*.tex) \
	$(wildcard tex-input/*/*.tex) \
	$(wildcard tex-input/*/*/*.tex)

BASENAME = slides

all : $(SLIDES)

clean : 
	trash $(wildcard slides*.pdf) \
	$(wildcard *.aux) \
	$(BASENAME).dvi \
	$(BASENAME).fdb_latexmk \
	$(BASENAME).fls \
	$(BASENAME).log \
	$(BASENAME).nav \
	$(BASENAME)*.out \
	$(BASENAME).snm \
	$(BASENAME).toc

$(SLIDES) : slides.rmd $(ALL_PLOTS) $(TEX_FILES)
	Rscript -e "rmarkdown::render(input = Sys.glob('*.rmd'), encoding = 'UTF-8')"

figures/weighted-dist-plot.pdf : scripts/weighted-dist-plotter.R
	$(RSCRIPT) $<

figures/conflict.pdf : scripts/conflict-plotter.R
	$(RSCRIPT) $<

figures/subpost-disagreement.pdf : scripts/plot-subpost-disagreement.R
	$(RSCRIPT) $<