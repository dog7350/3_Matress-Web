window.onclick = function (e) {
  dropdownList = document.getElementsByClassName("dropdown-content");
  element = e.target;
  if (element.matches(".dropbtn img")) {
    element = element.parentNode;
  }
  if (!element.matches(".dropbtn")) {
    for (i = 0; i < dropdownList.length; i++) {
      if (dropdownList[i].classList.contains("show")) {
        dropdownList[i].classList.remove("show");
        dropdownList[i].parentNode.classList.remove("drop");
        break;
      }
    }
  } else {
    parent = element.parentNode;
    if (!parent.classList.contains("drop")) {
      for (i = 0; i < dropdownList.length; i++) {
        if (dropdownList[i].classList.contains("show")) {
          dropdownList[i].classList.remove("show");
          dropdownList[i].parentNode.classList.remove("drop");
          break;
        }
      }
    }
    parent.classList.toggle("drop");
    parent
      .getElementsByClassName("dropdown-content")[0]
      .classList.toggle("show");
  }
};
