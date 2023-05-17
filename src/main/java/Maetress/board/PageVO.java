package Maetress.board;

public class PageVO {
    private int page; // 사용자가 요청한 페이지 번호
    private int countPerPage; // 한 페이지당 들어갈 게시물 개수

    public PageVO() {
        this.page = 1;
        this.countPerPage = 25;
    }

    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        this.page = page;
    }
    public int getCountPerPage() {
        return countPerPage;
    }
    public void setCountPerPage(int countPerPage) {
        this.countPerPage = countPerPage;
    }
}
