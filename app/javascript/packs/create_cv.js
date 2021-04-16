$('#zoom').change(function () {
	$('#resume').css('transform', `scale(${$(this).val() / 10})`)
});

function download(dataurl, filename) {
	var a = document.createElement("a");
	a.href = dataurl;
	a.setAttribute("download", filename);
	a.click();
}

// Global variable
var element = $("#resume");

$("#btn-download").on('click', function () {
	$('#field-text').html($('#curriculum_vitae_field_id option:selected').text());
	$('#curriculum_vitae_field_id').css('display', 'none');
	html2canvas(element.get(0)).then(function (canvas) {
		var imageData = canvas.toDataURL("image/png");

		// Now browser starts downloading
		// it instead of just showing it
		var newData = imageData.replace(
			/^data:image\/png/, "data:application/octet-stream");

		download(newData, "myCV.png");

		$('.text-area').each(function (i) {
			$('textarea').eq(i).html($(this).html());
		});

		$('#submit').click();
	});
});

$('#add-skill').on('click', function() {
	$('#skills').append(
		`<li class="skill">
			<div class="data text-area" contenteditable="true">Example Skill</div>
			<textarea class="d-none" name="curriculum_vitae[skills_attributes][${$('.skill').length}][skill_name]" id="curriculum_vitae_skills_attributes_${$('.skill').length}_skill_name"></textarea>
		</li>`
	);
});

$('#remove-skill').on('click', function() {
	$('.skill:last').remove();
});

$('#add-language').on('click', function() {
	$('#languages').append(
		`<li class="language">
				<div class="data">
					<span class="text-area" contenteditable="true">Language</span>:
					<span class="ml-1 text-area" contenteditable="true">Level</span>
				</div>
				<textarea class="d-none" name="curriculum_vitae[languages_attributes][${$('.language').length}][language_name]" id="curriculum_vitae_languages_attributes_${$('.language').length}_language_name"></textarea>
				<textarea class="d-none" name="curriculum_vitae[languages_attributes][${$('.language').length}][level]" id="curriculum_vitae_languages_attributes_${$('.language').length}_level"></textarea>
		</li>`
	);
});

$('#remove-language').on('click', function() {
	$('.language:last').remove();
});

$('#add-hobby').on('click', function() {
	$('#hobbies').append(
		`<li class="hobby">
			<div class="data text-area" contenteditable="true">Hobby</div>
      <textarea class="d-none" name="curriculum_vitae[hobbies_attributes][${$('.hobby').length}][hobby_name]" id="curriculum_vitae_hobbies_attributes_${$('.hobby').length}_hobby_name"></textarea>
		</li>`
	);
});

$('#remove-hobby').on('click', function() {
	$('.hobby:last').remove();
});

$('#add-education').on('click', function() {
	$('#educations').append(
		`<li class="education">
			<div class="date">
				<span class="text-area" contenteditable="true">7/2017</span> -
				<span class="text-area" contenteditable="true">10/2021</span>
				<textarea class="d-none" name="curriculum_vitae[educations_attributes][${$('.education').length}][start_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_start_date"></textarea>
				<textarea class="d-none" name="curriculum_vitae[educations_attributes][${$('.education').length}][end_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_end_date"></textarea>
			</div>
			<div class="info">
				<textarea class="d-none" name="curriculum_vitae[educations_attributes][${$('.education').length}][university_name]" id="curriculum_vitae_educations_attributes_${$('.education').length}_university_name"></textarea>
				<div class="font-weight-bold text-area" contenteditable="true">Duy Tan University</div>
				<div>Major: <span contenteditable="true" class="text-area">Software Engineering</span></div>
				<textarea class="d-none" name="curriculum_vitae[educations_attributes][${$('.education').length}][major]" id="curriculum_vitae_educations_attributes_${$('.education').length}_major"></textarea>
				<div contenteditable="true" class="text-area">GPA: 3.8</div>
				<textarea class="d-none" name="curriculum_vitae[educations_attributes][${$('.education').length}][gpa]" id="curriculum_vitae_educations_attributes_${$('.education').length}_gpa"></textarea>
			</div>
		</li>`
	);
});

$('#remove-education').on('click', function() {
	$('.education:last').remove();
});

$('#add-experience').on('click', function() {
	$('#experiences').append(
		`<li class="experience">
			<div class="date">
				<span class="text-area" contenteditable="true">7/2017</span> -
				<span class="text-area" contenteditable="true">10/2021</span>
				<textarea class="d-none" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][start_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_start_date"></textarea>
				<textarea class="d-none" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][end_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_end_date"></textarea>
			</div>
			<div class="info">
				<div class="font-weight-bold text-area" contenteditable="true">Marketing leader</div>
				<textarea class="d-none" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][position]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_position"></textarea>
				<div class="font-italic text-area" contenteditable="true">ABC Company</div>
				<textarea class="d-none" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][company_name]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_company_name"></textarea>
				<div contenteditable="true" class="text-area">- Manager stores Manager
					- Marketing planning and job assignment for subordinates.
					- Support to advertise products on media channels.</div>
				<textarea class="d-none" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][description]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_description"></textarea>
			</div>
		</li>`
	);
});

$('#remove-experience').on('click', function() {
	$('.experience:last').remove();
});

$('#remove-reference').on('click', function() {
	$('#add-reference').toggleClass("d-none");
	$('.title:last').toggleClass("d-none");
	$('.reference:last').remove();
});

$('#add-reference').on('click', function(){
	$(this).toggleClass("d-none");
	$('.title:last').toggleClass("d-none");
	$('#references').append(
		`<ul class="reference">
			<li>
				<div class="data">
					<div contenteditable="true" class="text-area">Ông Nguyễn Văn A</div>
					<textarea class="d-none" name="curriculum_vitae[references_attributes][0][name]" id="curriculum_vitae_references_attributes_0_name"></textarea>
					<div contenteditable="true" class="text-area">Giảng viên trường Đại học Duy Tân</div>
					<textarea class="d-none" name="curriculum_vitae[references_attributes][0][position]" id="curriculum_vitae_references_attributes_0_position"></textarea>
					<div>Email: <span contenteditable="true" class="text-area">example@example.com</span></div>
					<textarea class="d-none" name="curriculum_vitae[references_attributes][0][email]" id="curriculum_vitae_references_attributes_0_email"></textarea>
					<div>Phone number:<span contenteditable="true" class="text-area">(+84) 77 88 9999</span></div>
					<textarea class="d-none" name="curriculum_vitae[references_attributes][0][phone_number]" id="curriculum_vitae_references_attributes_0_phone_number"></textarea>
				</div>
			</li>
		</ul>`
	);
});
