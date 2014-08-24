// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery.timeago
//= require jquery.timeago.settings
//= require jquery_ujs
//= require turbolinks 
//= require bootstrap
//= require_tree .
//= require nprogress
//= require nprogress-turbolinks

$(document).ready(function(){
	//timeago 
	$("abbr.timeago").timeago();

	// reply a comment
	$(".reply").click(function(){
		$("#comment_content").focus().val("@" + $(this).data("name") + " ");
	})

	// user nav click
	$("#user-posts-nav li").click(function(){
		var index = $("#user-posts-nav li").index($(this));
		console.log(index);

		$(this).addClass("active")
					 .siblings("li").removeClass("active");

		var $selectSection = $(".user-posts div").children("section").eq(index);
		$selectSection.css("display", "block")
								.siblings().css("display", "none");
	})

		//Tag part
	var Tag = function(){

		return{
			enabled: function($dom){
				$dom.removeClass("tag-disabled");
				$dom.removeAttr("disabled");
			},

			disabled: function($dom){
				$dom.addClass("tag-disabled");
				$dom.attr("disabled","disabled");
			},
			addTo: function(className, val, $target){
				var tag = document.createElement("tag");
				tag.innerHTML = val;
				tag.className = className;
				$(tag).appendTo($target);
			},
			remove: function($dom){
				$dom.remove();
			},
			refresh: function($save_tag, spliter, $selectTags, $existTags){
				var tags_val = "", tag_token;
				$selectTags.find("tag").each(function(){
					tag_token = $(this).text() + spliter;
					var $selected_tags = $selectTags.children("tag"),
							$exist_tags = $existTags.find("tag");
					for (var i = 0; i < $exist_tags.length; i++) {
						if($(this).text() === $exist_tags.eq(i).text()){
							Tag.disabled($exist_tags.eq(i));
						}
					};
					tags_val += tag_token;
					$save_tag.val(tags_val);
				});
			},
			refreshData: function(){
				this.refresh($("#hid_tag"), "#tag#", $(".selected-tags"), $(".exist-tags"));
			}
		}
	}()

	//Tag init
		Tag.refreshData();

		//Tag actions
		$("#new-tag").bind("input",function(){
			$("#hid_swap").text($(this).val());
		});

		$("#new-tag").on("change", function(event){
			if($(this).val().trim()!= ""){
				Tag.addTo("sld-tag", $(this).val(), $(".selected-tags"));
				Tag.refreshData();
			}
			$(this).val("");
		});

		$("#new-tag").on("keypress", function(event){
			var _keyCode = event.which? event.which : event.keyCode;

			if(_keyCode == 13){
				if($(this).val().trim()!= ""){
					Tag.addTo("sld-tag", $(this).val(), $(".selected-tags"));
					Tag.refreshData();
				}
				$(this).val("");
				return false;
			}
		});

		$(document).on("click", ".selected-tags tag", function(){
			var tagText = $(this).text().trim();
			if(tagText != ""){
				$(".exist-tags").find("tag").each(function(){
					if($(this).text() === tagText){
						Tag.enabled($(this));
					}
				});
				Tag.remove($(this));
				Tag.refreshData();
			}
		});

		$(".exist-tags").children("tag").click(function(){
			if (!$(this).hasClass("tag-disabled")) {
				Tag.addTo("sld-tag", $(this).text(), $(".selected-tags"));			
				Tag.disabled($(this));
				Tag.refreshData();
			};
		});

});
