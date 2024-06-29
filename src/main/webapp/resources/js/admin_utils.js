function downloadExcel(tableName, title, currentPageOnly) {
    const url = "downloadExcel?tableName=" + tableName + "&title=" + title + "&currentPageOnly=" + currentPageOnly;
    window.location.href = url;
}

function excelFormDownload(tableName, title) {
    window.location.href = "excelFormDownload?tableName=" + tableName + "&title=" + title;
}