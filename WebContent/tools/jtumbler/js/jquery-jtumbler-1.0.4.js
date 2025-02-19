/*!
 jTumbler jQuery Plugin (1.0.4)
 (c) 2013-2014 www.w3Blender.com
 For any questions and support please visit www.w3blender.com.
 */
;(function ($) {
    /**
     * Default options.
     */
    var defaults = {
        onSwitch: null
    };

    $.fn.jTumbler = function (options)
    {
        // Initialize default options
        var settings = $.extend(defaults, options);

        /**
         * Private members.
         */
        var $self = this;

        /**
         * Initialize plug-in.
         */
        this.init = function ()
        {
            $(this).each(function(i, switcher) {
                $self.swap(switcher);
            });
        };

        /**
         * Replace original DOM tree with new element
         * @param item
         */
        this.swap = function(item)
        {
            var html = $self.generateHtml(item);

            if(html === false) {
                return;
            }

            $(html).insertBefore(item);
            $(item).hide();

            $(item).siblings(".jtumbler").on("click", "label", $self.switchState);
        };

        /**
         * Generate new HTML items
         * @param item
         * @returns {*}
         */
        this.generateHtml = function(item)
        {
            var inputs = $('input[type="radio"]', item);

            if(inputs.length === 0) {
                return false;
            }

            var id = "",
                label = "",
                value = "",
                items = [],
                width = Math.floor(100 / inputs.length);

            for(var i = 0; i < inputs.length; i++) {
                id = $(inputs[i]).prop("id");
                if(id === null || id === "") {
                    id = $self.createUniqueId();
                    $(inputs[i]).prop("id", id);
                }
                label = $('label[for="' + id + '"]');
                value = (label.length > 0 ? $(label).text() : $(inputs[i]).val());
                items.push('<label for="' + id + '" class="state' + (i === 0 ? ' first' : '') + (i + 1 >= inputs.length ? ' last' : '') + ($(inputs[i]).prop('checked') ? ' active' : '') + '" style="width: ' + width + '%"><span></span><strong>' + value + '</strong></label>');
            }

            if(items.length > 0) {
                return '<div class="jtumbler">' + items.join("") + '</div>';
            }

            return false;
        };

        /**
         * Generate unique ID
         * @returns {string}
         */
        this.createUniqueId = function()
        {
            return Math.floor((1 + Math.random()) * 0x10000)
                .toString(16)
                .substring(1);
        };

        /**
         * Switch tumbler state handler
         * @returns {boolean}
         */
        this.switchState = function()
        {
            if($(this).hasClass("active")) {
                return false;
            }

            var obj = this,
                slider = $('<span class="slider"></span>').appendTo($(obj).parents('.jtumbler')),
                active = $(obj).parents('.jtumbler').find('label.active'),
                destPos = $(obj).position(),
                srcPos = $(active).position(),
                prevChecked = $("input#" + active.attr("for")),
                checked = $("#" + $(this).attr("for"));

            if(srcPos == undefined) {
                srcPos = $(obj).position();
            }

            $(slider).width($(obj).outerWidth());
            $(slider).css({left: srcPos.left});

            if($(this).hasClass('first')) {
                $(slider).addClass('first');
            }

            if($(this).hasClass('last')) {
                $(slider).addClass('last');
            }

            $(slider).show(1, function() {
                $(obj).parents('.jtumbler').find('label.active').removeClass('active');

                $(slider).animate({left: destPos.left}, 200, function() {
                    $(obj).parents('.jtumbler').find('.slider').remove();
                    $(obj).addClass('active');
                    // $(slider).remove();

                    if(typeof settings.onSwitch === "function") {
                        settings.onSwitch(checked, prevChecked);
                    }
                });
            });

            return true;
        };

        this.getChecked = function()
        {
            return $('input[type="radio"]:checked', this);
        };

        this.init();

        return this;
    };
}(jQuery));