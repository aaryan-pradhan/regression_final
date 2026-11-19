# This book's settings (read by the Makefile). `make source C=rtsm P=391-400` renders scan pages.
SRC_bda     := src/scans/bda.pdf
SRC_rtsm    := src/scans/rtsm.pdf
SRC_fe      := src/scans/fe_general_full.pdf
SRC_feslides:= src/scans/fe_slides.pdf
SRC_finecon := src/scans/fin_econ.pdf
SRC_regpca  := src/scans/regpca.pdf
SRC_stats   := src/scans/stats_training.pdf
SRC         := $(SRC_bda)
BANNED      := BDA RTSM FE Bakshi Banerjee Ashutosh Dripto
VERIFY      :=

# The finished book is also copied to regression_final.pdf (gitignored).
.PHONY: pdf
pdf: build check
	cp build/main.pdf regression_final.pdf
