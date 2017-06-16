OUTPUTDIR=$(BASEDIR)/output  
GITHUB_REPO_SLUG=blog/uabharuhi.github.io
GITHUB_REMOTE_NAME=origin  
GITHUB_PAGES_BRANCH=master  
# �H�W�ѼƽЮھڻݨD�ۦ����  
GITHUB_COMMIT_MSG=$(shell git --no-pager log --format=%s -n 1)  

travis: publish  
    # �� Travis CI �]�w git �� user.name �M user.email  
    # �S�]�w email ���ܡAGitHub �W���ݨ쪺 Author �|�O Unknown  
    git config --global user.name "uabharuhi - Travis"  
    git config --global user.email uabharuhi@gmail.com  

    # �N Pelican output dir �����e commit �� GitHub Pages �Ϊ� branch�A�ǳ� push �W�h  
    # �]���ڥΪ��O user site�A�ҥH branch �O master�C�p�G�O project site ���ܡAbranch �|�O gh-pages  
    ghp-import -n -r $(GITHUB_REMOTE_NAME) -b $(GITHUB_PAGES_BRANCH) -m "$(GITHUB_COMMIT_MSG)" $(OUTPUTDIR)  

    # �N��誺 commit force push �� GitHub �W�ۦP�� branch  
    # ���� -f (force push) ���ܤ@�w�|�]�� conflict �ӥ���  
    # �]���C�� Travis CI build �u�|���@�� commit  
    # �ӥB�� branch �u�|�s�@���R�A�ɮסA�C���ܰʳ��ܤj�A�S��ԣ�ݭn�O�s commit log �����n�ʡC  
    @git push -fq https://${GH_TOKEN}@github.com/$(GITHUB_REPO_SLUG).git $(GITHUB_PAGES_BRANCH):$(GITHUB_PAGES_BRANCH) > /dev/null  
    # �� @ �i�H�� Travis CI ���n��ܳo��b log �W�A�o�˧O�H�N���|�ݨ�A�� GitHub Personal Access Token �F�A�]�N�O�o�̥Ϊ� ${GH_TOKEN} 