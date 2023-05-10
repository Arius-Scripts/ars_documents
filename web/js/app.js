let edit = false;

let disabledInputs = (bool) => {
	$("#name").prop("disabled", bool);
	$("#surname").prop("disabled", bool);
	$("#date").prop("disabled", bool);
	$("#textarea").prop("disabled", bool);
	$("#textarea-information").prop("disabled", bool);
	$("#image-link").prop("disabled", bool);
};

let clearInputs = () => {
	$("#page-title").val("");

	$("#name").val("");
	$("#surname").val("");
	$("#date").val("");

	$("#textarea").val("");
	$("#textarea-information").val("");
	$("#signature").text("Click to sign");
};

let updateImage = () => {
	let src = $("#image-link").val();

	if (src == "") {
		src = "https://cdn.discordapp.com/attachments/1017732810200596500/1078323961080848444/ARIUSDEVLOGO.png";
	}

	$("#image-src").attr("src", src);
};

window.addEventListener("message", (event) => {
	let action = event.data;

	if (action.action === "view") {
		$("#container").fadeIn(500);
		$("#container").css("display", "flex");
		$("#signature").css("transform", "scale(1.0)");

		$("#page-title").val(action.metadata.title);
		$("#image-src").attr("src", action.metadata.src);

		$("#name").val(action.metadata.name);
		$("#surname").val(action.metadata.surname);
		$("#date").val(action.metadata.date);

		$("#textarea").val(action.metadata.object);
		$("#textarea-information").val(action.metadata.guidelines);
		$("#signature").text(action.metadata.sign);

		disabledInputs(true);
		edit = false;
	} else if (action.action === "create") {
		$("#container").fadeIn(500);

		$("#container").css("display", "flex");
		$("#page-title").text(action.metadata.title);

		disabledInputs(false);
		edit = true;
	}
});

$(document).on("click", "#signature", function () {
	if (edit) {
		let src = $("#image-link").val();

		if (src == "") {
			src = "https://cdn.discordapp.com/attachments/1017732810200596500/1078323961080848444/ARIUSDEVLOGO.png";
		}

		$.post(
			`https://${GetParentResourceName()}/giveItem`,
			JSON.stringify({
				title: $("#page-title").val(),

				name: $("#name").val(),
				surname: $("#surname").val(),
				date: $("#date").val(),

				object: $("#textarea").val(),

				guidelines: $("#textarea-information").val(),
				image: src,
			})
		);

		$("#container").fadeOut(500);
		clearInputs();
	}
});

document.onkeyup = function (data) {
	if (data.which == 27) {
		$.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));

		$("#container").fadeOut(500);
		clearInputs();
	}
};
