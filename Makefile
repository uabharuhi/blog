OUTPUTDIR=$(BASEDIR)/output  
GITHUB_REPO_SLUG=blog/uabharuhi.github.io
GITHUB_REMOTE_NAME=origin  
GITHUB_PAGES_BRANCH=master  
# 以上參數請根據需求自行替換  
GITHUB_COMMIT_MSG=$(shell git --no-pager log --format=%s -n 1)  

travis: publish  
    # 為 Travis CI 設定 git 的 user.name 和 user.email  
    # 沒設定 email 的話，GitHub 上面看到的 Author 會是 Unknown  
    git config --global user.name "uabharuhi - Travis"  
    git config --global user.email uabharuhi@gmail.com  

    # 將 Pelican output dir 的內容 commit 到 GitHub Pages 用的 branch，準備 push 上去  
    # 因為我用的是 user site，所以 branch 是 master。如果是 project site 的話，branch 會是 gh-pages  
    ghp-import -n -r $(GITHUB_REMOTE_NAME) -b $(GITHUB_PAGES_BRANCH) -m "$(GITHUB_COMMIT_MSG)" $(OUTPUTDIR)  

    # 將剛剛的 commit force push 到 GitHub 上相同的 branch  
    # 不用 -f (force push) 的話一定會因為 conflict 而失敗  
    # 因為每次 Travis CI build 只會有一個 commit  
    # 而且該 branch 只會存一堆靜態檔案，每次變動都很大，沒有啥需要保存 commit log 的必要性。  
    @git push -fq https://${GH_TOKEN}@github.com/$(GITHUB_REPO_SLUG).git $(GITHUB_PAGES_BRANCH):$(GITHUB_PAGES_BRANCH) > /dev/null  
    # 用 @ 可以讓 Travis CI 不要顯示這行在 log 上，這樣別人就不會看到你的 GitHub Personal Access Token 了，也就是這裡用的 ${GH_TOKEN} 