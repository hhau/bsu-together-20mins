RSCRIPT = Rscript
SLIDES = slides.pdf

ALL_PLOTS = figures/weighted-dist-plot.pdf \
	figures/conflict.pdf

TEX_FILES = $(wildcard tex-input/*.tex) \
	$(wildcard tex-input/*/*.tex) \
	$(wildcard tex-input/*/*/*.tex)

all : $(SLIDES)

$(SLIDES) : slides.rmd $(ALL_PLOTS) $(TEX_FILES)
	Rscript -e "rmarkdown::render(input = Sys.glob('*.rmd'), encoding = 'UTF-8')"

figures/weighted-dist-plot.pdf : scripts/weighted-dist-plotter.R
	$(RSCRIPT) $<

figures/conflict.pdf : scripts/conflict-plotter.R
	$(RSCRIPT) $<