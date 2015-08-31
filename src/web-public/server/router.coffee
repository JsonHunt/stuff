express = require 'express'
service = require './service'
multer  = require('multer')
gm = require 'gm'
router = express.Router()

router.use multer(
	dest: './graphicFiles/'
	onFileUploadComplete: (file,req,res)->
		#
		# fullPath = "graphicFiles\\#{file.name}"
		# console.log fullPath
		# gm(fullPath)
		# .resize(300, 200)
		# .crop(data.w, data.h, data.x, data.y)
		# .write fullPath, (err)->
		# 	if err
		# 		console.log err
		# 	else
		# 		console.log "File resized and cropped"
		console.log "File upload complete"
)

router.use '/crop', (req,res,next)->
	fullPath = "graphicFiles\\#{req.body.imageURL}"
	data = req.body.data
	gm(fullPath).size (err,value)->
		console.log err if err
		gm(fullPath)
		.scale(value.width * data.scale, value.height * data.scale)
		.crop(data.w,data.h,data.x,data.y)
		.write fullPath, (err)->
			if err
				console.log err
			else
				console.log "File scaled and cropped"
			res.send "OK"

router.use '/uploadGraphic', (req,res,next)->
	console.log req.files
	res.json {result: 'success', file: req.files.file.name}

router.use '/getPrivateUserData', (req,res,next)-> res.json {data:"This is for private eyes only"}

module.exports = router
