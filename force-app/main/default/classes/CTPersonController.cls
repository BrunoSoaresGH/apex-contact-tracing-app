public with sharing class CTPersonController {

    public static String getToken(String mobileNumber){
        Blob value = Blob.valueOf(mobileNumber);
        Blob hash = Crypto.generateDigest('MD5', value);

        //Getting the string value of hash blob
        return EncodingUtil.base64Encode(hash);
    }
    
}
