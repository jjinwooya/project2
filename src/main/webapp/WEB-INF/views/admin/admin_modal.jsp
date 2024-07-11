<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
	function excelSubmit(){
	    event.preventDefault();
	    var form = $('#myForm')[0];
	    var formData = new FormData(form);
	    console.log(formData);
	    $.ajax({
	        url: 'uploadData',
	        type: 'POST',
	        data: formData,
	        processData: false, // 필수: FormData를 문자열로 변환하지 않도록 설정
	        contentType: false, // 필수: multipart/form-data 사용 설정
	        success: function (response) {
	        		alert(response.message);
	                location.reload();
	        },
	        error: function (xhr, status, error) {
	            alert('파일 업로드 실패: ' + xhr.responseText);
	        }
	    });
	}
</script>
    <div class="modal fade" id="excelUploadModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">데이터 업로드</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="myForm" enctype="multipart/form-data">
                        ★양식을 다운로드 후 양식에 맞춰 올려주세요 
                        <button type="button" class="btn btn-success" onclick="excelFormDownload('${tableName}', '양식 엑셀파일')">양식 다운로드</button>
                        <div class="mb-3">
                            <input class="form-control" type="file" id="formFile" name="file" accept=".xlsx,.xls">
                        </div>
                        <span>.xlsx  .xls 파일만 업로드 가능합니다</span>
                        <br>
                        <input type="hidden" name="tableName" value="${tableName}">
                       <input type="button" class="btn btn-primary" value="업로드" id="submitBtn" onclick="excelSubmit()">
                    </form>
                </div>
            </div>
        </div>
    </div>