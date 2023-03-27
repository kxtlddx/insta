let imageCount = 0;
let scrollCount = 0;

let scrollLeftButtons = document.querySelectorAll(".scroll_left");
let scrollRightButtons = document.querySelectorAll(".scroll_right");

scrollLeftButtons.forEach(function (button) {
    button.addEventListener("click", function () {
        let container = button.previousElementSibling;
        let imagePreview = container.querySelector(".image_preview");
        let images = imagePreview.querySelectorAll("img");
        let imageWidth = images[0].offsetWidth + 5;
        container.scrollLeft -= imageWidth;
    });
});
scrollRightButtons.forEach(function (button) {
    button.addEventListener("click", function () {
        let container = button.previousElementSibling.previousElementSibling;
        let imagePreview = container.querySelector(".image_preview");
        let images = imagePreview.querySelectorAll("img");
        let imageWidth = images[0].offsetWidth + 5;
        container.scrollLeft += imageWidth;
    });
});

/*document.querySelectorAll(".post_images").forEach(function (postImages) {
    postImages.addEventListener("change", function (event) {
        let preview = event.target.closest(".image_preview_container").querySelector(".image_preview");
        preview.innerHTML = "";
        let files = event.target.files;
        for (let i = 0; i < files.length; i++) {
            let file = files[i];
            let reader = new FileReader();
            reader.onloadend = function () {
                let img = document.createElement("img");
                img.src = reader.result;
                img.style.width = "100%";
                img.style.display = "inline-block";
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        }
    });
});*/

document.getElementById("post_images").addEventListener("change", function (event) {
    let preview = event.target.closest("div").nextElementSibling.querySelector(".image_preview");
    preview.innerHTML = "";
    let files = event.target.files;
    imageCount = files.length - 1;
    scrollCount = 0;
    for (let i = 0; i < files.length; i++) {
        let file = files[i];
        let reader = new FileReader();
        reader.onloadend = function () {
            let img = document.createElement("img");
            img.src = reader.result;
            img.style.width = "100%";
            img.style.height = "100%";
            img.style.objectFit = "cover";
            img.style.display = "inline-block";
            preview.appendChild(img);
        }
        reader.readAsDataURL(file);
    }
});