pull <- function(pkg,usr="JARS3N"){
  message(paste0("Pulling...  ",pkg))
  system(paste0("git clone ",file.path("https://github.com",usr,paste0(pkg,".git"))))
}

commit <- function(pkg,msg){
  #setwd(pkg)
  system("git add *")
  system(paste0("git commit -m ",shQuote(msg)))

}

Config_name <- function(name){
  system( paste0("git config --global user.name ", name))
}
Config_email <- function(email){
  system( paste0("git config --global user.email ", email))
}

push <- function(username,password,pkg){
  system(paste0("git push https://" , username, ":" ,
                password, "@", pkg,"/file.git --all"))
}

pushOriginMaster <- function(){
  system("git push origin master")
}
clone <- function(repo){
  system(paste0("git clone https://github.com/",repo,".git"))
}

# setwd("..")
#
# system("git init")
# system("git add *")
# commitGit("rere","sdfsfsfsfsd")
# system("git remote add origin https://github.com/JARS3N/rere.git")
# system("git remote -v")
# system("git push -u origin master")
#
# system('git clone https://github.com/JARS3N/git.git')
# setwd('git')

updateGithub <- function(pkg,msg="",rev = "dev"){
  revision(rev)
  system("git add *")
  commit(pkg,msg)
  system("git remote -v")
  pushOriginMaster()
}

####

revision <- function(rev="dev") {
desc <- readLines("DESCRIPTION",warn = F)
ver <-  gsub("Version: ","",grep("Version: ",desc,value = T))
split <- as.numeric(strsplit(ver,"[.]")[[1]])
names(split) <- c("major","minor","dev")
split[rev] <- split[rev] + 1
revD <- paste(split,collapse = '.')
desc[grep("Version: ",desc)] <- paste0("Version: ",revD)
desc[grep("LastUpdate: ",desc)] <- paste0("LastUpdate: ",date())
writeLines(desc,"DESCRIPTION")
}
