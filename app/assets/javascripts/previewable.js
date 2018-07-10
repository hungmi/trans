// 參考用法
// <%= f.file_field :icon, class: "d-none previewable" %>
// <%= image_tag tag.icon_or_default, style: "max-width: 100%;", class: "previewer", data: { file: "input#tag_icon" } %>

var $imagePreviewer = $(`<div class="card"><img class="card-img-top img-fluid" src=""></div>`)

$(document).on("click", "img.previewer", function(e) {
	var target = this.getAttribute("data-file")
	document.querySelector(target).click()
})

$(document).on("change", "input[type='file'].previewable", function(e) {
	if (this.files !== undefined) {
		$("#newImagePreview").html('')
		for (file of this.files) {
			var $previewer = $imagePreviewer.clone()
			$previewer.addClass($("#newImagePreview").attr("data-previewerClass"))
			$previewer.appendTo($("#newImagePreview"))
			previewFile($previewer.find("img")[0], file)	
		}
	}
})

function previewFile(previewer, file){
	// var file    = file_input.files[0]; //sames as here
	var reader  = new FileReader();

	reader.onloadend = function () {
	  previewer.src = reader.result;
	}

	if (file) {
	  reader.readAsDataURL(file); //reads the data as a URL
	} else {
	  // previewer.src = "";
	}
}