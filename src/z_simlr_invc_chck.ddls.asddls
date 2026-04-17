@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'Z_SIMLRINVCHCK1'
@EndUserText.label: 'Same Invoice Check'
@OData.publish: true

define view Z_SIMLR_INVC_CHCK
as select from bkpf
inner join bseg
on bkpf.belnr = bseg.belnr
and bkpf.bukrs = bseg.bukrs
and bkpf.gjahr = bseg.gjahr
{
/* Primary Key (MANDATORY for OData) */
key bkpf.bukrs,
key bseg.lifnr,
key bkpf.xblnr,

/* Additional Fields */
bkpf.belnr,
bkpf.gjahr,
bseg.dmbtr,
bkpf.waers,
bkpf.budat
}
where
bkpf.budat >= dats_add_days(
cast( $session.system_date as abap.dats ),
-90,
'NULL'
)
and bkpf.stblg = ''
and bseg.lifnr <> ''
and bkpf.xblnr <> ''
