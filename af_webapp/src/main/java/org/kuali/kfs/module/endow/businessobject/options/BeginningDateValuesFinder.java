/*
 * Copyright 2011 The Kuali Foundation.
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
package org.kuali.kfs.module.endow.businessobject.options;

import java.util.ArrayList;
import java.util.List;

import org.kuali.kfs.module.endow.document.service.MonthEndDateService;
import org.kuali.kfs.sys.context.SpringContext;
import org.kuali.rice.core.api.util.ConcreteKeyValue;
import org.kuali.rice.core.api.util.KeyValue;
import org.kuali.rice.krad.keyvalues.KeyValuesBase;

public class BeginningDateValuesFinder extends KeyValuesBase {

    public List<KeyValue> getKeyValues() {

        MonthEndDateService monthEndDateService = SpringContext.getBean(MonthEndDateService.class);
        List<KeyValue> labels = new ArrayList<KeyValue>();
        List<String> monthEndDates = monthEndDateService.getBeginningDates();
        for (String monthEndDate : monthEndDates) {
            labels.add(new ConcreteKeyValue(monthEndDate, monthEndDate));
        }
        return labels;
    }
}
