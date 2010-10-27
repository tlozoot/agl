/*
   SoundManager 2: Javascript Sound for the Web
   --------------------------------------------
   http://www.schillmania.com/projects/soundmanager2/

   Copyright (c) 2007, Scott Schiller. All rights reserved.
   Code licensed under the BSD License:
   http://www.schillmania.com/projects/soundmanager2/license.txt

   V2.0b.20070415
*/
function SoundManager(smURL,smID){var self=this;this.version='V2.0b.20070415';this.url=(smURL||'soundmanager2.swf');this.debugMode=true;this.useConsole=true;this.consoleOnly=false;this.nullURL='data/null.mp3';this.defaultOptions={'autoLoad':false,'stream':true,'autoPlay':false,'onid3':null,'onload':null,'whileloading':null,'onplay':null,'whileplaying':null,'onstop':null,'onfinish':null,'onbeforefinish':null,'onbeforefinishtime':5000,'onbeforefinishcomplete':null,'onjustbeforefinish':null,'onjustbeforefinishtime':200,'multiShot':true,'pan':0,'volume':100}
this.allowPolling=true;this.enabled=false;this.o=null;this.id=(smID||'sm2movie');this.oMC=null;this.sounds=[];this.soundIDs=[];this.isIE=(navigator.userAgent.match(/MSIE/));this.isSafari=(navigator.userAgent.match(/safari/i));this.debugID='soundmanager-debug';this._debugOpen=true;this._didAppend=false;this._appendSuccess=false;this._didInit=false;this._disabled=false;this._hasConsole=(typeof console!='undefined'&&typeof console.log!='undefined');this._debugLevels=!self.isSafari?['debug','info','warn','error']:['log','log','log','log'];this.getMovie=function(smID){return self.isIE?window[smID]:(self.isSafari?document[smID+'-embed']:document.getElementById(smID+'-embed'));}
this.loadFromXML=function(sXmlUrl){try{self.o._loadFromXML(sXmlUrl);}catch(e){self._failSafely();return true;}}
this.createSound=function(oOptions){if(!self._didInit)throw new Error('soundManager.createSound(): Not loaded yet - wait for soundManager.onload() before calling sound-related methods');if(arguments.length==2){oOptions={'id':arguments[0],'url':arguments[1]}}
var thisOptions=self._mergeObjects(oOptions);self._writeDebug('soundManager.createSound(): "<a href="#" onclick="soundManager.play(\''+thisOptions.id+'\');return false" title="play this sound">'+thisOptions.id+'</a>" ('+thisOptions.url+')',1);if(self._idCheck(thisOptions.id,true)){self._writeDebug('sound '+thisOptions.id+' already defined - exiting',2);return false;}
self.sounds[thisOptions.id]=new SMSound(self,thisOptions);self.soundIDs[self.soundIDs.length]=thisOptions.id;try{self.o._createSound(thisOptions.id,thisOptions.onjustbeforefinishtime);}catch(e){self._failSafely();return true;}
if(thisOptions.autoLoad||thisOptions.autoPlay)self.sounds[thisOptions.id].load(thisOptions);if(thisOptions.autoPlay)self.sounds[thisOptions.id].playState=1;}
this.destroySound=function(sID){if(!self._idCheck(sID))return false;for(var i=self.soundIDs.length;i--;){if(self.soundIDs[i]==sID){delete self.soundIDs[i];continue;}}
self.sounds[sID].unload();delete self.sounds[sID];}
this.load=function(sID,oOptions){if(!self._idCheck(sID))return false;self.sounds[sID].load(oOptions);}
this.unload=function(sID){if(!self._idCheck(sID))return false;self.sounds[sID].unload();}
this.play=function(sID,oOptions){if(!self._idCheck(sID)){if(typeof oOptions!='Object')oOptions={url:oOptions};if(oOptions&&oOptions.url){self._writeDebug('soundController.play(): attempting to create "'+sID+'"',1);oOptions.id=sID;self.createSound(oOptions);}else{return false;}}
self.sounds[sID].play(oOptions);}
this.start=this.play;this.setPosition=function(sID,nMsecOffset){if(!self._idCheck(sID))return false;self.sounds[sID].setPosition(nMsecOffset);}
this.stop=function(sID){if(!self._idCheck(sID))return false;self._writeDebug('soundManager.stop('+sID+')',1);self.sounds[sID].stop();}
this.stopAll=function(){self._writeDebug('soundManager.stopAll()',1);for(var oSound in self.sounds){if(self.sounds[oSound]instanceof SMSound)self.sounds[oSound].stop();}}
this.pause=function(sID){if(!self._idCheck(sID))return false;self.sounds[sID].pause();}
this.resume=function(sID){if(!self._idCheck(sID))return false;self.sounds[sID].resume();}
this.togglePause=function(sID){if(!self._idCheck(sID))return false;self.sounds[sID].togglePause();}
this.setPan=function(sID,nPan){if(!self._idCheck(sID))return false;self.sounds[sID].setPan(nPan);}
this.setVolume=function(sID,nVol){if(!self._idCheck(sID))return false;self.sounds[sID].setVolume(nVol);}
this.setPolling=function(bPolling){if(!self.o||!self.allowPolling)return false;self._writeDebug('soundManager.setPolling('+bPolling+')');self.o._setPolling(bPolling);}
this.disable=function(){if(self._disabled)return false;self._disabled=true;self._writeDebug('soundManager.disable(): Disabling all functions - future calls will return false.',1);for(var i=self.soundIDs.length;i--;){self._disableObject(self.sounds[self.soundIDs[i]]);}
self.initComplete();self._disableObject(self);}
this.getSoundById=function(sID,suppressDebug){if(!sID)throw new Error('SoundManager.getSoundById(): sID is null/undefined');var result=self.sounds[sID];if(!result&&!suppressDebug){self._writeDebug('"'+sID+'" is an invalid sound ID.',2);}
return result;}
this.onload=function(){soundManager._writeDebug('<em>Warning</em>: soundManager.onload() is undefined.',2);}
this.onerror=function(){}
this._idCheck=this.getSoundById;this._disableObject=function(o){for(var oProp in o){if(typeof o[oProp]=='function'&&typeof o[oProp]._protected=='undefined')o[oProp]=function(){return false;}}
oProp=null;}
this._failSafely=function(){var flashCPLink='http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html';var fpgssTitle='You may need to whitelist this location/domain eg. file:///C:/ or C:/ or mysite.com, or set ALWAYS ALLOW under the Flash Player Global Security Settings page. Note that this seems to apply only to file system viewing.';var flashCPL='<a href="'+flashCPLink+'" title="'+fpgssTitle+'">view/edit</a>';var FPGSS='<a href="'+flashCPLink+'" title="Flash Player Global Security Settings">FPGSS</a>';if(!self._disabled){self._writeDebug('soundManager: JS-&gt;Flash communication failed. Possible causes: flash/browser security restrictions ('+flashCPL+'), insufficient browser/plugin support, or .swf not found',2);self._writeDebug('Verify that the movie path of <em>'+self.url+'</em> is correct (<a href="'+self.url+'" title="If you get a 404/not found, fix it!">test link</a>)',1);if(self._didAppend){if(!document.domain){self._writeDebug('Loading from local file system? (document.domain appears to be null, this URL path may need to be added to \'trusted locations\' in '+FPGSS+')',1);self._writeDebug('Possible security/domain restrictions ('+flashCPL+'), should work when served by http on same domain',1);}}
self.disable();}}
this._createMovie=function(smID,smURL){if(self._didAppend&&self._appendSuccess)return false;if(window.location.href.indexOf('debug=1')+1)self.debugMode=true;self._didAppend=true;var html=['<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="16" height="16" id="'+smID+'"><param name="movie" value="'+smURL+'"><param name="quality" value="high"><param name="allowScriptAccess" value="always" /></object>','<embed name="'+smID+'-embed" id="'+smID+'-embed" src="'+smURL+'" width="1" height="1" quality="high" allowScriptAccess="always" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed>'];var toggleElement='<div id="'+self.debugID+'-toggle" style="position:fixed;_position:absolute;right:0px;bottom:0px;_top:0px;width:1.2em;height:1.2em;line-height:1.2em;margin:2px;padding:0px;text-align:center;border:1px solid #999;cursor:pointer;background:#fff;color:#333;z-index:706" title="Toggle SM2 debug console" onclick="soundManager._toggleDebug()">-</div>';var debugHTML='<div id="'+self.debugID+'" style="display:'+(self.debugMode&&((!self._hasConsole||!self.useConsole)||(self.useConsole&&self._hasConsole&&!self.consoleOnly))?'block':'none')+';opacity:0.85"></div>';var appXHTML='soundManager._createMovie(): appendChild/innerHTML set failed. Serving application/xhtml+xml MIME type? Browser may be enforcing strict rules, not allowing write to innerHTML. (PS: If so, this means your commitment to XML validation is going to break stuff now, because this part isn\'t finished yet. ;))';var sHTML='<div style="position:absolute;left:-256px;top:-256px;width:1px;height:1px" class="movieContainer">'+html[self.isIE?0:1]+'</div>'+(self.debugMode&&((!self._hasConsole||!self.useConsole)||(self.useConsole&&self._hasConsole&&!self.consoleOnly))&&!document.getElementById(self.debugID)?'x'+debugHTML+toggleElement:'');var oTarget=(document.body?document.body:document.getElementsByTagName('div')[0]);if(oTarget){self.oMC=document.createElement('div');self.oMC.className='movieContainer';self.oMC.style.position='absolute';self.oMC.style.left='0px';self.oMC.style.width='1px';self.oMC.style.height='1px';try{oTarget.appendChild(self.oMC);self.oMC.innerHTML=html[self.isIE?0:1];self._appendSuccess=true;}catch(e){throw new Error(appXHTML);}
if(!document.getElementById(self.debugID)&&((!self._hasConsole||!self.useConsole)||(self.useConsole&&self._hasConsole&&!self.consoleOnly))){var oDebug=document.createElement('div');oDebug.id=self.debugID;oDebug.style.display=(self.debugMode?'block':'none');if(self.debugMode){try{var oD=document.createElement('div');oTarget.appendChild(oD);oD.innerHTML=toggleElement;}catch(e){throw new Error(appXHTML);}}
oTarget.appendChild(oDebug);}
oTarget=null;}
self._writeDebug('-- SoundManager 2 Version '+self.version.substr(1)+' --',1);self._writeDebug('soundManager._createMovie(): trying to load <a href="'+smURL+'" title="Test this link (404=bad)">'+smURL+'</a>',1);}
this._writeDebug=function(sText,sType){if(!self.debugMode)return false;if(self._hasConsole&&self.useConsole){console[self._debugLevels[sType]||'log'](sText);if(self.useConsoleOnly)return true;}
var sDID='soundmanager-debug';try{var o=document.getElementById(sDID);if(!o)return false;var p=document.createElement('div');p.innerHTML=sText;o.insertBefore(p,o.firstChild);}catch(e){}
o=null;}
this._writeDebug._protected=true;this._writeDebugAlert=function(sText){alert(sText);}
if(window.location.href.indexOf('debug=alert')+1){self.debugMode=true;self._writeDebug=self._writeDebugAlert;}
this._toggleDebug=function(){var o=document.getElementById(self.debugID);var oT=document.getElementById(self.debugID+'-toggle');if(!o)return false;if(self._debugOpen){oT.innerHTML='+';o.style.display='none';}else{oT.innerHTML='-';o.style.display='block';}
self._debugOpen=!self._debugOpen;}
this._toggleDebug._protected=true;this._debug=function(){self._writeDebug('soundManager._debug(): sounds by id/url:',0);for(var i=0,j=self.soundIDs.length;i<j;i++){self._writeDebug(self.sounds[self.soundIDs[i]].sID+' | '+self.sounds[self.soundIDs[i]].url,0);}}
this._mergeObjects=function(oMain,oAdd){var o1=oMain;var o2=(typeof oAdd=='undefined'?self.defaultOptions:oAdd);for(var o in o2){if(typeof o1[o]=='undefined')o1[o]=o2[o];}
return o1;}
this.createMovie=function(sURL){if(sURL)self.url=sURL;self._initMovie();}
this._initMovie=function(){if(self.o)return false;self.o=self.getMovie(self.id);if(!self.o){self._createMovie(self.id,self.url);self.o=self.getMovie(self.id);}
if(self.o){self._writeDebug('soundManager._initMovie(): Got '+self.o.nodeName+' element ('+(self._didAppend?'created via JS':'static HTML')+')',1);}}
this.initComplete=function(){if(self._didInit)return false;self._didInit=true;self._writeDebug('-- SoundManager 2 '+(self._disabled?'failed to load':'loaded')+' ('+(self._disabled?'security/load error':'OK')+') --',1);if(self._disabled){self._writeDebug('soundManager.initComplete(): calling soundManager.onerror()',1);self.onerror.apply(window);return false;}
self._writeDebug('soundManager.initComplete(): calling soundManager.onload()',1);try{self.onload.apply(window);}catch(e){self._writeDebug('soundManager.onload() threw an exception: '+e.message,2);throw e;}
self._writeDebug('soundManager.onload() complete',1);}
this.init=function(){if(window.removeEventListener){window.removeEventListener('load',self.beginInit,false);}else if(window.detachEvent){window.detachEvent('onload',self.beginInit);}
try{self.o._externalInterfaceTest();self._writeDebug('Flash ExternalInterface call (JS -&gt; Flash) succeeded.',1);if(!self.allowPolling)self._writeDebug('Polling (whileloading/whileplaying support) is disabled.',1);self.setPolling(true);self.enabled=true;}catch(e){self._failSafely();self.initComplete();return false;}
self.initComplete();}
this.beginDelayedInit=function(){setTimeout(self.beginInit,200);}
this.beginInit=function(){self.createMovie();self._initMovie();setTimeout(self.init,1000);}
this.destruct=function(){if(self.isSafari){for(var i=self.soundIDs.length;i--;){if(self.sounds[self.soundIDs[i]].readyState==1)self.sounds[self.soundIDs[i]].unload();}}
self.disable();}}
function SMSound(oSM,oOptions){var self=this;var sm=oSM;this.sID=oOptions.id;this.url=oOptions.url;this.options=sm._mergeObjects(oOptions);this.id3={}
self.resetProperties=function(bLoaded){self.bytesLoaded=null;self.bytesTotal=null;self.position=null;self.duration=null;self.durationEstimate=null;self.loaded=false;self.loadSuccess=null;self.playState=0;self.paused=false;self.readyState=0;self.didBeforeFinish=false;self.didJustBeforeFinish=false;}
self.resetProperties();this.load=function(oOptions){self.loaded=false;self.loadSuccess=null;self.readyState=1;self.playState=(oOptions.autoPlay||false);var thisOptions=sm._mergeObjects(oOptions);if(typeof thisOptions.url=='undefined')thisOptions.url=self.url;try{sm._writeDebug('loading '+thisOptions.url,1);sm.o._load(self.sID,thisOptions.url,thisOptions.stream,thisOptions.autoPlay,thisOptions.whileloading?1:0);}catch(e){sm._writeDebug('SMSound().load(): JS-&gt;Flash communication failed.',2);}}
this.unload=function(){sm._writeDebug('SMSound().unload(): "'+self.sID+'"');self.setPosition(0);sm.o._unload(self.sID,sm.nullURL);self.resetProperties();}
this.play=function(oOptions){if(!oOptions)oOptions={};if(oOptions.onfinish)self.options.onfinish=oOptions.onfinish;if(oOptions.onbeforefinish)self.options.onbeforefinish=oOptions.onbeforefinish;if(oOptions.onjustbeforefinish)self.options.onjustbeforefinish=oOptions.onjustbeforefinish;var thisOptions=sm._mergeObjects(oOptions);if(self.playState==1){var allowMulti=thisOptions.multiShot;if(!allowMulti){sm._writeDebug('SMSound.play(): "'+self.sID+'" already playing? (one-shot)',1);return false;}else{sm._writeDebug('SMSound.play(): "'+self.sID+'" already playing (multi-shot)',1);}}
if(!self.loaded){if(self.readyState==0){sm._writeDebug('SMSound.play(): .play() before load request. Attempting to load "'+self.sID+'"',1);thisOptions.stream=true;thisOptions.autoPlay=true;self.load(thisOptions);}else if(self.readyState==2){sm._writeDebug('SMSound.play(): Could not load "'+self.sID+'" - exiting',2);return false;}else{sm._writeDebug('SMSound.play(): "'+self.sID+'" is loading - attempting to play..',1);}}else{sm._writeDebug('SMSound.play(): "'+self.sID+'"');}
if(self.paused){self.resume();}else{self.playState=1;self.position=(thisOptions.offset||0);if(thisOptions.onplay)thisOptions.onplay.apply(self);self.setVolume(thisOptions.volume);self.setPan(thisOptions.pan);if(!thisOptions.autoPlay){sm.o._start(self.sID,thisOptions.loop||1,self.position);}}}
this.start=this.play;this.stop=function(bAll){if(self.playState==1){self.playState=0;self.paused=false;if(sm.defaultOptions.onstop)sm.defaultOptions.onstop.apply(self);sm.o._stop(self.sID);}}
this.setPosition=function(nMsecOffset){sm.o._setPosition(self.sID,nMsecOffset/1000,self.paused||!self.playState);}
this.pause=function(){if(self.paused)return false;sm._writeDebug('SMSound.pause()');self.paused=true;sm.o._pause(self.sID);}
this.resume=function(){if(!self.paused)return false;sm._writeDebug('SMSound.resume()');self.paused=false;sm.o._pause(self.sID);}
this.togglePause=function(){sm._writeDebug('SMSound.togglePause()');if(!self.playState){self.play({offset:self.position/1000});return false;}
if(self.paused){sm._writeDebug('SMSound.togglePause(): resuming..');self.resume();}else{sm._writeDebug('SMSound.togglePause(): pausing..');self.pause();}}
this.setPan=function(nPan){if(typeof nPan=='undefined')nPan=0;sm.o._setPan(self.sID,nPan);self.options.pan=nPan;}
this.setVolume=function(nVol){if(typeof nVol=='undefined')nVol=100;sm.o._setVolume(self.sID,nVol);self.options.volume=nVol;}
this._whileloading=function(nBytesLoaded,nBytesTotal,nDuration){self.bytesLoaded=nBytesLoaded;self.bytesTotal=nBytesTotal;self.duration=nDuration;self.durationEstimate=parseInt((self.bytesTotal/self.bytesLoaded)*self.duration);if(self.readyState!=3&&self.options.whileloading)self.options.whileloading.apply(self);}
this._onid3=function(oID3PropNames,oID3Data){sm._writeDebug('SMSound()._onid3(): "'+this.sID+'" ID3 data received.');var oData=[];for(var i=0,j=oID3PropNames.length;i<j;i++){oData[oID3PropNames[i]]=oID3Data[i];}
self.id3=sm._mergeObjects(self.id3,oData);if(self.options.onid3)self.options.onid3.apply(self);}
this._whileplaying=function(nPosition){if(isNaN(nPosition)||nPosition==null)return false;self.position=nPosition;if(self.playState==1){if(self.options.whileplaying)self.options.whileplaying.apply(self);if(self.loaded&&self.options.onbeforefinish&&self.options.onbeforefinishtime&&!self.didBeforeFinish&&self.duration-self.position<=self.options.onbeforefinishtime){sm._writeDebug('duration-position &lt;= onbeforefinishtime: '+self.duration+' - '+self.position+' &lt= '+self.options.onbeforefinishtime+' ('+(self.duration-self.position)+')');self._onbeforefinish();}}}
this._onload=function(bSuccess){bSuccess=(bSuccess==1?true:false);sm._writeDebug('SMSound._onload(): "'+self.sID+'"'+(bSuccess?' loaded.':' failed to load (or loaded from cache - weird bug) - [<a href="'+self.url+'">test URL</a>]'));self.loaded=bSuccess;self.loadSuccess=bSuccess;self.readyState=bSuccess?3:2;if(self.options.onload)self.options.onload.apply(self);}
this._onbeforefinish=function(){if(!self.didBeforeFinish){self.didBeforeFinish=true;if(self.options.onbeforefinish)self.options.onbeforefinish.apply(self);}}
this._onjustbeforefinish=function(msOffset){if(!self.didJustBeforeFinish){self.didJustBeforeFinish=true;if(self.options.onjustbeforefinish)self.options.onjustbeforefinish.apply(self);;}}
this._onfinish=function(){sm._writeDebug('SMSound._onfinish(): "'+self.sID+'"');self.playState=0;self.paused=false;if(self.options.onfinish)self.options.onfinish.apply(self);if(self.options.onbeforefinishcomplete)self.options.onbeforefinishcomplete.apply(self);self.setPosition(0);self.didBeforeFinish=false;self.didJustBeforeFinish=false;}}
var soundManager=new SoundManager();if(window.addEventListener){window.addEventListener('load',soundManager.beginDelayedInit,false);window.addEventListener('beforeunload',soundManager.destruct,false);}else if(window.attachEvent){window.attachEvent('onload',soundManager.beginInit);window.attachEvent('beforeunload',soundManager.destruct);}else{soundManager.onerror();soundManager.disable();}