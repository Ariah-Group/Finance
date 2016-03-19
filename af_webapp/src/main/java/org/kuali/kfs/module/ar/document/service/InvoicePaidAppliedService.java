/*
 * Copyright 2008 The Kuali Foundation
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
package org.kuali.kfs.module.ar.document.service;

import java.util.Collection;

import org.kuali.kfs.module.ar.businessobject.AppliedPayment;
import org.kuali.kfs.module.ar.businessobject.InvoicePaidApplied;
import org.kuali.kfs.module.ar.document.CustomerInvoiceDocument;

public interface InvoicePaidAppliedService<T extends AppliedPayment> {
    
    public Integer getNumberOfInvoicePaidAppliedsForInvoiceDetail(String financialDocumentReferenceInvoiceNumber, Integer invoiceItemNumber);
    
    /**
     * 
     * Clears all the PaidApplieds for the given document number from the database.
     * This is typically done prior to loading a new set of lines in.
     * 
     * NOTE that this will delete the Paid Applieds that were generated BY the 
     * documentNumber passed in, not that apply TO the documentNumber passed in.
     * 
     * @param documentNumber
     */
    public void clearDocumentPaidAppliedsFromDatabase(String documentNumber);
    
    /**
     * This method doesn't go to the database to get related invoice paid applieds.
     * It looks at a specific document to get the relations worked out.
     * 
     * @param customerInvoiceDetail
     * @param paymentApplicationDocument
     * @return
     */
//    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsForCustomerInvoiceDetail(CustomerInvoiceDetail customerInvoiceDetail, PaymentApplicationDocument paymentApplicationDocument);
    
    /**
     * This method returns true if invoice has applied amounts (i.e. from application, credit memo, etc), not including
     * discounts
     * 
     * @param document
     * @return
     */
    public boolean doesInvoiceHaveAppliedAmounts(CustomerInvoiceDocument document);

    /**
     * @param documentNumber
     * @return
     */
    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsForInvoice(String documentNumber);

    /**
     * @param documentNumber
     * @return
     */
    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsForInvoice(CustomerInvoiceDocument invoice);
    
    /**
     * @param customerInvoiceDetail
     * @return
     */
//    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsForCustomerInvoiceDetail(CustomerInvoiceDetail customerInvoiceDetail);
//    public Collection<InvoicePaidApplied> getApprovedInvoicePaidAppliedsForCustomerInvoiceDetail(CustomerInvoiceDetail customerInvoiceDetail);
//    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsForCustomerInvoiceDetail(CustomerInvoiceDetail customerInvoiceDetail, String applicationDocNumber);
//    public Collection<InvoicePaidApplied> getInvoicePaidAppliedsFromSpecificDocument(String documentNumber, String referenceCustomerInvoiceDocumentNumber);
    
}