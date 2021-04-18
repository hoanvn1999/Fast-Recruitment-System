$(document).ready(function() {
	$('#btn-modal').click();
});

$('#btn-submit-field, #btn-close').on('click', function () {
	$('#field-text').html($('#curriculum_vitae_field_id option:selected').text());
});

$("#curriculum_vitae_cv_image").change(function (e) {
	var data = new FormData();
	data.append('file', e.originalEvent.srcElement.files[0]); // This is file object

	var xhr = new XMLHttpRequest();

	xhr.addEventListener("readystatechange", function () {
		if (this.readyState === this.DONE) {
			let jsonString = JSON.parse(this.responseText);
			console.log(jsonString);
			for (i = 0; i < 5; i++) {
				if (jsonString.result[0].prediction[i].label == "About_me")
					$('#curriculum_vitae_about_me').val(jsonString.result[0].prediction[i].ocr_text.replace(/\n/g, " "));
				else if (jsonString.result[0].prediction[i].label == "Education") {
					educations = jsonString.result[0].prediction[i].ocr_text.split('\n');
					$('.education:last').remove();
					// for(j = 0; j < educations.length / 2; j++){
						$('#educations').append(
							`<div class="education">
								<label for="curriculum_vitae_educations_attributes_${$('.education').length}_university_name">University name</label>
								<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][university_name]" id="curriculum_vitae_educations_attributes_0_university_name" value="${educations[0]}">
								<div class="row">
									<div class="col-6">
										<label for="curriculum_vitae_educations_attributes_${$('.education').length}_start_date">Start date</label>
										<input class="form-control" type="month" name="curriculum_vitae[educations_attributes][${$('.education').length}][start_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_start_date">
									</div>
									<div class="col-6">
										<label for="curriculum_vitae_educations_attributes_${$('.education').length}_end_date">End date</label>
										<input class="form-control" type="month" name="curriculum_vitae[educations_attributes][${$('.education').length}][end_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_end_date">
									</div>
								</div>
								<div class="row">
									<div class="col-9">
										<label for="curriculum_vitae_educations_attributes_${$('.education').length}_major">Major:</label>
										<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][major]" id="curriculum_vitae_educations_attributes_${$('.education').length}_major" value="${educations[1].replace('Major:','')}">
									</div>
									<div class="col-3">
										<label for="curriculum_vitae_educations_attributes_${$('.education').length}_gpa">Gpa</label>
										<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][gpa]" id="curriculum_vitae_educations_attributes_${$('.education').length}_gpa" value="${educations[2].replace('GPA:','')}">
									</div>
								</div>
							</div>`
						);
					// }
				}
				else if (jsonString.result[0].prediction[i].label == "Experience") {
					var textString = jsonString.result[0].prediction[i].ocr_text.split('\n');
					$('.experience:last').remove();
					var count = 0;
					var arr = [];
					for(j = 0; j < textString.length; j++) {
						if (textString[j].indexOf('osition') !== -1){
							count = count + 1;
							arr.push(j);
						}
					}
					arr.push(textString.length + 1);
					for(j = 0; j < count; j++) {
						pos_head = arr[0];
						pos_tail = arr[1];
						arr.shift();
						var des = '';
						for(k = pos_head + 1; k < pos_tail-1; k++){
							des = des + ' ' + textString[k];
						}
						$('#experiences').append(
							`<div class="experience">
								<div class="info">
									<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_company_name">Company name</label>
									<input class="form-control" type="text" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][company_name]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_company_name" value="${textString[pos_head-1]}">
									<div class="row">
										<div class="col-6">
											<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_start_date">Start date</label>
											<input class="form-control" type="month" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][start_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_start_date">
										</div>
										<div class="col-6">
											<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_end_date">End date</label>
											<input class="form-control" type="month" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][end_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_end_date">
										</div>
									</div>
									<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_position">Position</label>
									<input class="form-control" type="text" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][position]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_position" value="${textString[pos_head]}">
									<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_description">Description</label>
									<textarea class="form-control" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][description]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_description">${des}</textarea>
								</div>
							</div>`
						)
					}
				}
				else if (jsonString.result[0].prediction[i].label == "Skills") {
					skills = jsonString.result[0].prediction[i].ocr_text.split('\n');
					$('.skill:last').remove();
					for(j = 0; j < skills.length; j++){
						$('#skills').append(
							`<div class="skill">
                <label for="curriculum_vitae_skills_attributes_${$('.skill').length}_skill_name">Skills</label>
                <input class="form-control" type="text" name="curriculum_vitae[skills_attributes][${$('.skill').length}][skill_name]" id="curriculum_vitae_skills_attributes_${$('.skill').length}_skill_name" value="${skills[j].replace('- ', '')}">
            	</div>`
						)
					}
				}
				else {
					languages = jsonString.result[0].prediction[i].ocr_text.split('\n');
					$('.language:last').remove();
					for(j = 0; j < languages.length; j++){
						language = languages[j].split(':');
						$('#languages').append(
							`<div class="language">
								<div class="row">
									<div class="col-6">
										<label for="curriculum_vitae_languages_attributes_0_language_name">Language</label>
										<input class="form-control" type="text" name="curriculum_vitae[languages_attributes][${$('.language').length}][language_name]" id="curriculum_vitae_languages_attributes_0_language_name" value="${language[0].replace('- ', '')}">
									</div>
									<div class="col-6">
										<label for="curriculum_vitae_languages_attributes_0_level">Level</label>
										<input class="form-control" type="text" name="curriculum_vitae[languages_attributes][${$('.language').length}][level]" id="curriculum_vitae_languages_attributes_${$('.language').length}_level value="${language[1]}">
									</div>
								</div>
							</div>`
						)
					}
				}
			}
		}
	});

	xhr.open("POST", "https://app.nanonets.com/api/v2/OCR/Model/074c0a48-5987-4e33-a0a5-65d7a3943cde/LabelFile/");
	xhr.setRequestHeader("authorization", "Basic " + btoa("4m7EuDBahqVO5s7rBpYp4I94qbkyLZ46:"));

	xhr.send(data);
	alert('Please wait, we will scan your CV and autofill the form shortly.');
});

$('#add-skill').on('click', function() {
	$('#skills').append(
		`<div class="skill">
			<label for="curriculum_vitae_skills_attributes_${$('.skill').length}_skill_name">Kỹ năng</label>
			<input class="form-control" type="text" name="curriculum_vitae[skills_attributes][${$('.skill').length}][skill_name]" id="curriculum_vitae_skills_attributes_${$('.skill').length}_skill_name">
		</div>`
	);
});

$('#remove-skill').on('click', function() {
	$('.skill:last').remove();
});

$('#add-language').on('click', function() {
	$('#languages').append(
		`<div class="language">
			<div class="row">
				<div class="col-6">
					<label for="curriculum_vitae_languages_attributes_${$('.language').length}_language_name">Ngôn Ngữ</label>
					<input class="form-control" type="text" name="curriculum_vitae[languages_attributes][${$('.language').length}][language_name]" id="curriculum_vitae_languages_attributes_${$('.language').length}_language_name">
				</div>
				<div class="col-6">
					<label for="curriculum_vitae_languages_attributes_${$('.language').length}_level">Level</label>
					<input class="form-control" type="text" name="curriculum_vitae[languages_attributes][${$('.language').length}][level]" id="curriculum_vitae_languages_attributes_${$('.language').length}_level">
				</div>
			</div>
		</div>`
	);
});

$('#remove-language').on('click', function() {
	$('.language:last').remove();
});

$('#add-hobby').on('click', function() {
	$('#hobbies').append(
		`<div class="hobby">
			<label for="curriculum_vitae_hobbies_attributes_${$('.hobby').length}_hobby_name"> Sở thích</label>
			<input class="form-control" type="text" name="curriculum_vitae[hobbies_attributes][${$('.hobby').length}][hobby_name]" id="curriculum_vitae_hobbies_attributes_${$('.hobby').length}_hobby_name">
		</div>`
	);
});

$('#remove-hobby').on('click', function() {
	$('.hobby:last').remove();
});

$('#add-education').on('click', function() {
	$('#educations').append(
		`<div class="education">
			<label for="curriculum_vitae_educations_attributes_${$('.education').length}_university_name">University name</label>
			<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][university_name]" id="curriculum_vitae_educations_attributes_0_university_name">
			<div class="row">
				<div class="col-6">
					<label for="curriculum_vitae_educations_attributes_${$('.education').length}_start_date">Start date</label>
					<input class="form-control" type="month" name="curriculum_vitae[educations_attributes][${$('.education').length}][start_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_start_date">
				</div>
				<div class="col-6">
					<label for="curriculum_vitae_educations_attributes_${$('.education').length}_end_date">End date</label>
					<input class="form-control" type="month" name="curriculum_vitae[educations_attributes][${$('.education').length}][end_date]" id="curriculum_vitae_educations_attributes_${$('.education').length}_end_date">
				</div>
			</div>
			<div class="row">
				<div class="col-9">
					<label for="curriculum_vitae_educations_attributes_${$('.education').length}_major">Major:</label>
					<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][major]" id="curriculum_vitae_educations_attributes_${$('.education').length}_major">
				</div>
				<div class="col-3">
					<label for="curriculum_vitae_educations_attributes_${$('.education').length}_gpa">Gpa</label>
					<input class="form-control" type="text" name="curriculum_vitae[educations_attributes][${$('.education').length}][gpa]" id="curriculum_vitae_educations_attributes_${$('.education').length}_gpa">
				</div>
			</div>
		</div>`
	);
});

$('#remove-education').on('click', function() {
	$('.education:last').remove();
});

$('#add-experience').on('click', function() {
	$('#experiences').append(
		`<div class="experience">
			<div class="info">
				<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_company_name">Company name</label>
				<input class="form-control" type="text" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][company_name]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_company_name">
				<div class="row">
					<div class="col-6">
						<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_start_date">Start date</label>
						<input class="form-control" type="month" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][start_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_start_date">
					</div>
					<div class="col-6">
						<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_end_date">End date</label>
						<input class="form-control" type="month" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][end_date]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_end_date">
					</div>
				</div>
				<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_position">Position</label>
				<input class="form-control" type="text" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][position]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_position">
				<label for="curriculum_vitae_experiences_attributes_${$('.experience').length}_description">Description</label>
				<textarea class="form-control" name="curriculum_vitae[experiences_attributes][${$('.experience').length}][description]" id="curriculum_vitae_experiences_attributes_${$('.experience').length}_description"></textarea>
			</div>
		</div>`
	);
});

$('#remove-experience').on('click', function() {
	$('.experience:last').remove();
});
