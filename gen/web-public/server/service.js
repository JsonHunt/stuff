// Generated by CoffeeScript 1.9.1
(function() {
  var FastBricks, PublicService, emailjs, fb, sql, uuid;

  sql = require('sql-bricks');

  FastBricks = require('fast-bricks');

  emailjs = require("emailjs/email");

  uuid = require('node-uuid');

  fb = new FastBricks();

  fb.loadConfig('database-config.cson');

  PublicService = (function() {
    function PublicService() {}

    PublicService.prototype.server = emailjs.server.connect({
      user: "lukasz.korzeniowski@gmail.com",
      password: "G4rsonk4",
      host: "smtp.gmail.com",
      port: "465",
      ssl: true
    });

    PublicService.prototype.signup = function(user, callback) {
      var email, username;
      if (!user.username) {
        callback("User name is required");
        return;
      }
      if (!user.password) {
        callback("Password is required");
        return;
      }
      if (!user.email) {
        callback("Email is required");
        return;
      }
      username = {
        username: user.username
      };
      email = {
        email: user.email
      };
      return fb.query(sql.select().from('`user`').where(username), (function(_this) {
        return function(err, result) {
          if (result.length > 0) {
            callback("This user name is not available");
            return;
          }
          return fb.query(sql.select().from('`user`').where(email), function(err, result) {
            var newuser;
            if (result.length > 0) {
              callback("This email is not available");
              return;
            }
            newuser = {
              username: user.username,
              password: user.password,
              email: user.email,
              activation_code: uuid.v1(),
              verification: 0
            };
            return _this.sendActivationEmail(newuser, function(err) {
              if (err) {
                console.log(err);
                return callback("There was a problem with the activation email");
              } else {
                return fb.query(sql.insert('`user`', newuser), (function(_this) {
                  return function(err, result) {
                    newuser.id = result.insertId;
                    delete newuser.password;
                    return callback(void 0, newuser);
                  };
                })(this));
              }
            });
          });
        };
      })(this));
    };

    PublicService.prototype.login = function(username, password, callback) {
      var expr;
      expr = sql.select().from('`user`').where({
        username: username,
        password: password
      });
      return fb.query(expr, function(err, result) {
        var user;
        if (result.length === 0) {
          return callback("This username/password is not valid");
        } else {
          user = result[0];
          if (user.validation === 0) {
            return callback("This account hasn't been verified yet. Check your email");
          } else {
            return callback(void 0, user);
          }
        }
      });
    };

    PublicService.prototype.sendEmail = function(msg, callback) {
      return this.server.send(msg, function(err, message) {
        var email;
        if (err) {
          return callback(err);
        } else {
          email = {
            '`text`': msg.text,
            '`from`': msg.from,
            '`to`': msg.to,
            '`subject`': msg.subject,
            '`status`': "sent",
            '`time_sent`': new Date()
          };
          return fb.query(sql.insert('email', email), function(err, result) {
            if (err) {
              return callback(err);
            } else {
              return callback();
            }
          });
        }
      });
    };

    PublicService.prototype.sendActivationEmail = function(user, callback) {
      var msg;
      msg = {
        text: "http://localhost:3000/rest/activateAccount?code=" + user.activation_code,
        from: "Webapp <accounts@webapp.com>",
        to: user.email,
        subject: "Account activation link " + user.activation_code
      };
      return this.sendEmail(msg, callback);
    };

    PublicService.prototype.activateUser = function(activationCode, callback) {
      return fb.query(sql.select().from('`user`').where({
        activation_code: activationCode
      }), function(err, results) {
        var user;
        if (results.length === 0) {
          return callback("Error: invalid activation code");
        } else {
          user = results[0];
          return fb.query(sql.update('`user`', {
            verification: 1
          }).where({
            id: user.id
          }), function(err, result) {
            return callback();
          });
        }
      });
    };

    PublicService.prototype.requestPasswordReset = function(email, callback) {
      if (!email || email.length === 0) {
        callback("Please enter your email");
      }
      return fb.query(sql.select().from('`user`').where({
        email: email
      }), (function(_this) {
        return function(err, results) {
          var msg, passcode, user;
          if (results.length === 0) {
            return callback("We do not have an account associated with this email");
          } else {
            user = results[0];
            passcode = uuid.v1();
            msg = {
              text: "http://localhost:3000/rest/resetPassword?code=" + passcode,
              from: "Webapp <accounts@webapp.com>",
              to: user.email,
              subject: "Password reset link " + passcode
            };
            return _this.sendEmail(msg, function(err) {
              if (err) {
                return callback(err);
              } else {
                return fb.query(sql.update('`user`', {
                  password_code: passcode
                }).where({
                  id: user.id
                }), function(err, result) {
                  if (err) {
                    return callback(err);
                  } else {
                    return callback();
                  }
                });
              }
            });
          }
        };
      })(this));
    };

    PublicService.prototype.resetPassword = function(code, callback) {
      return fb.query(sql.select().from('`user`').where({
        password_code: code
      }), function(err, results) {
        if (err) {
          return callback(err);
        } else if (results.length === 0) {
          return callback("This code is invalid");
        } else {
          return callback(void 0, results[0]);
        }
      });
    };

    PublicService.prototype.changePassword = function(user, password, callback) {
      if (!user) {
        callback("You must be logged in to change your password");
      }
      if (!password) {
        callback("Password is required");
      }
      return fb.query(sql.update('`user`', {
        password: password
      }).where({
        id: user.id
      }), function(err, result) {
        return callback(err);
      });
    };

    return PublicService;

  })();

  module.exports = new PublicService();

}).call(this);
