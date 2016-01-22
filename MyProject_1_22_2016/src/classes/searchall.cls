public with sharing class searchall {
    @RemoteAction public static string[] searchableElements() {
        String[] terms = new String[0];
        for(Sobjecttype t:schema.getglobaldescribe().values())
            if(t.getdescribe().issearchable())
                terms.add(string.valueof(t));
        return terms;
    }
    @RemoteAction public static sobject[] searchQuery(string entity, string term) {
        return search.query('find :term in all fields returning '+entity)[0];
    }
}