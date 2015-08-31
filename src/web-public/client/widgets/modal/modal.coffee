class ModalService
	open: (config)->
		$('body').append("<div class=''></div>")

	close: (result)->


module.exports = new ModalService()
