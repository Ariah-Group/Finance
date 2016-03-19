/*
 * Copyright 2007 The Kuali Foundation.
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl2.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 function loadFeeMethodDesc(feeMethodCodeFieldName){
	var elPrefix = findElPrefix( feeMethodCodeFieldName.name );
	var feeMethodCodeDescriptionFieldName = elPrefix + ".feeMethod.name";
 	setFeeMethodCodeDescription(feeMethodCodeFieldName, feeMethodCodeDescriptionFieldName);
 }
  
 function setFeeMethodCodeDescription( feeMethodCodeFieldName, feeMethodCodeDescriptionFieldName ){
 
	var feeMethodCode = dwr.util.getValue( feeMethodCodeFieldName );
    
	if (feeMethodCode =='') {
		clearRecipients(feeMethodCodeDescriptionFieldName);
	} else {
		feeMethodCode = feeMethodCode.toUpperCase();
		
		var dwrReply = {
			callback:function(data) {
			if ( data != null && typeof data == 'object' ) {
				setRecipientValue( feeMethodCodeDescriptionFieldName, data.name );
			} else {
				setRecipientValue( feeMethodCodeDescriptionFieldName, wrapError( "fee method description not found" ), true );			
			} },
			errorHandler:function( errorMessage ) { 
				setRecipientValue( feeMethodCodeDescriptionFieldName, wrapError( "fee method description not found" ), true );
			}
		};
		FeeMethodService.getByPrimaryKey( feeMethodCode, dwrReply );
	}
}
