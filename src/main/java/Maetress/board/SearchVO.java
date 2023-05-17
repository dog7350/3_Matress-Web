package Maetress.board;

public class SearchVO extends PageVO {
    private String keyword;
    private String condition;

    public SearchVO() {
        this.keyword = "";
        this.condition = "제목";
    }

    public String getKeyword() {
        return keyword;
    }
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    public String getCondition() {
        return condition;
    }
    public void setCondition(String condition) {
        this.condition = condition;
    }
}
