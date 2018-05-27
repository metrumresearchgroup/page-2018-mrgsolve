author <- c("*")

pkgs <- c("tidyverse", "mrgsolve", "knitr", "rmarkdown", "data.table", 
          "caTools", "bitops", "formatR", "git2r")


pkgRoot <- "/data/page-packages"
pkgDir <- file.path(pkgRoot, "src", "contrib")
pkgDir <- normalizePath(pkgDir)
libDir <- "/data/page-Rlibs"

if(!dir.exists(pkgDir)) dir.create(pkgDir, recursive = TRUE)
if(!dir.exists(libDir)) dir.create(libDir)

.libPaths(libDir)

user <- Sys.info()["user"]

fromCRAN <- user %in% author | "*" %in% author

local_repos <- paste0("file://",pkgRoot)
metrum_repos <- "https://metrumresearchgroup.github.io/r_validated/"
cran_repos <- "https://cran.rstudio.com/"
repos <- c(mrg = metrum_repos, cran = cran_repos, local = local_repos)


deps <- tools::package_dependencies(
  packages = pkgs,
  which = c("Depends", "Imports", "LinkingTo"),
  recursive = TRUE,
  db = available.packages(repos=repos[c("mrg", "cran")])
)

deps <- unlist(deps, use.names=FALSE)

pkgs <- unique(c(pkgs,deps))

base <- rownames(installed.packages(priority=c("base", "recommended")))

pkgs <- setdiff(pkgs,base)

tools::write_PACKAGES(pkgDir)

if(file.exists(file.path(pkgDir,"PACKAGES"))){
  available <- available.packages(repos = repos["local"])[,"Package"]
} else{
  available <- NULL
  file.create(file.path(pkgDir,"PACKAGES"))
  tools::write_PACKAGES(pkgDir)
}

if(fromCRAN){
  
  newpkgs <- setdiff(pkgs, available)
  
  if(length(newpkgs) > 0){
    ## These packages are installed either from mrg or cran
    install.packages(newpkgs,
                     lib=libDir,
                     repos = repos[c("mrg", "cran")],
                     destdir=pkgDir,
                     type="source", 
                     INSTALL_opts="--no-multiarch")
    
    tools::write_PACKAGES(pkgDir)
  }
  
  ## If multiple authors qcing each other, a package could be available
  ## but uninstalled.  Install from local.
  uninstalled <- setdiff(pkgs, installed.packages(libDir))
  
  if(length(uninstalled)>0){
    install.packages(uninstalled,
                     lib = libDir,
                     repos = repos["local"],
                     type = "source",
                     INSTALL_opts="--no-multiarch")
  }    
}


if(!fromCRAN){
  installed <- row.names(installed.packages(libDir))
  newpkgs <- setdiff(pkgs, installed)
  if(length(newpkgs)>0){
    install.packages(newpkgs,
                     lib = libDir,
                     repos = repos["local"],
                     type = "source",
                     INSTALL_opts="--no-multiarch")
    
  }
}

.ignore_libs <- function(root=getwd(),lib="lib", ci=FALSE) {
  
  if(!missing(root) & file.exists(root)) {
    lib <- file.path(root,"lib")
  }
  if(!file.exists(lib)) stop("Could not find lib directory")
  libs <- list.files(lib, full.names=FALSE)
  libs <- c(libs, "ignore.txt", "PACKAGES", "PACKAGES.gz")
  writeLines(con=file.path(lib,"ignore.txt"), libs)
  setwd(lib)
  system("svn propset svn:ignore -F ignore.txt .")
  setwd("..")
  if(ci) system("svn ci -m \"ignoring libs\" .")
}